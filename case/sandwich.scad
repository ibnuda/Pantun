screw_locations = [
    [ -7.90468,  6.28256 ],
    [ 73.90468,  6.28256 ],
    [ 186.425,  6.28256 ],
    [ 266.425,  6.28256 ],
    [ -11.90468,  -38.28256 ],
    [ -7.90468,  -81.28256 ],
    [ 266.425,  -81.28256 ],
    [ 270.425,  -38.28256 ],
    [ 43.90468,  -81.28256 ],
    [ 228.425,  -81.28256 ],
];

module
screw_holes()
{
    for (i = [0:len(screw_locations) - 1]) {
        translate(screw_locations[i]) circle(r = 1.1, $fn = 20);
    }
}

module
base_shape(val = 15)
{
    offset(val) import("pcb-shape.dxf");
}

module
pcb_shape()
{
    offset(0.5) import("pcb-shape.dxf");
}

module
caps_area()
{
    union() {
        offset(0.5) import("caps-area-left.dxf");
        offset(0.5) import("caps-area-right.dxf");
    }
}

module 2u()
{
    union()
    {
        color("red") translate([ -19.05, 9.525, 0 ]) import("2u-keebio.dxf");
    }
}

module
switch_holes()
{
    union()
    {
        import("switch-holes.dxf");
        // right spacebar.
        translate([ 172.281514, -78.423288 ]) rotate([ 0, 0, 192 ]) 2u();
        // left spacebar.
        translate([ 87.982678, -76.212569 ]) rotate([ 0, 0, 168 ]) 2u();
    }
}

module
promicro_and_reset_area()
{
    polygon(points = [
        [ 120, 30 ],
        [ 120, -32 ],
        [ 142, -32 ],
        [ 142, -12 ],
        [ 148, -12 ],
        [ 148, 30 ],
    ]);
}

module
base_plate(val = 15)
{
    difference()
    {
        base_shape(val);
        screw_holes();
    }
}

module
bottom_plate(val = 15)
{
    difference()
    {
        base_shape(val);
        screw_holes();
        promicro_and_reset_area();
    }
}

module
back_feet_3(val = 15)
{
    difference()
    {
        intersection()
        {
            base_shape(val);
            translate([ -40, -80, 0 ])
                square(size = [ 400, 600 ], center = false);
        }
        screw_holes();
        promicro_and_reset_area();
    }
}

module
back_feet_2(val = 15)
{
    difference()
    {
        intersection()
        {
            base_shape(val);
            translate([ -40, -50, 0 ])
                square(size = [ 400, 600 ], center = false);
        }
        screw_holes();
    }
}

module
back_feet_1(val = 15)
{
    difference()
    {
        intersection()
        {
            base_shape(val);
            translate([ -40, -20, 0 ])
                square(size = [ 400, 600 ], center = false);
        }
        screw_holes();
    }
}

module
back_feet_0()
{
    difference()
    {
        intersection()
        {
            base_shape();
            translate([ -40, 10, 0 ])
                square(size = [ 400, 600 ], center = false);
        }
        screw_holes();
    }
}

module
middle_plate(val = 15)
{
    difference()
    {
        base_plate(val);
        pcb_shape();
        promicro_and_reset_area();
    }
}

module
switch_plate(val = 15)
{
    difference()
    {
        base_plate(15);
        promicro_and_reset_area();
        switch_holes();
    }
}

module
second_plate(val = 15)
{
    difference()
    {
        base_plate(val);
        caps_area();
        promicro_and_reset_area();
    }
}

module
top_plate(val = 15)
{
    difference()
    {
        base_plate(val);
        caps_area();
    }
}

rotate([ 6, 0, 0 ]) translate([ 0, 0, 9 ]) union()
{
    //  translate([ 0, 0, -12]) color("blue")  linear_extrude(height = 3) back_feet_0();
     translate([ 0, 0, -9 ]) color("red")   linear_extrude(height = 3) back_feet_1(11);
     translate([ 0, 0, -6 ]) color("green") linear_extrude(height = 3) back_feet_2(11);
     translate([ 0, 0, -3 ]) color("blue")  linear_extrude(height = 3) back_feet_3(11);
     translate([ 0, 0, 0 ])  color("green") linear_extrude(height = 3) bottom_plate(12);
     translate([ 0, 0, 3 ])  color("blue")  linear_extrude(height = 3) middle_plate(13);
     translate([ 0, 0, 6 ])  color("red")   linear_extrude(height = 3) middle_plate(14);
     translate([ 0, 0, 9 ])  color("black") linear_extrude(height = 3) switch_plate(15);
     translate([ 0, 0, 12 ]) color("blue")  linear_extrude(height = 3) second_plate(14);
     translate([ 0, 0, 15 ]) color("red")   linear_extrude(height = 3) second_plate(13);
     translate([ 0, 0, 18 ]) color("green") linear_extrude(height = 3) top_plate(12);
}


// translate([0, 0, 0])    bottom_plate();
// translate([0, -150, 0]) middle_plate();
// translate([0,  0,   0]) middle_plate();
// translate([0,  150, 0]) switch_plate();
// translate([0,  300, 0]) top_plate();
// translate([0,  450, 0]) top_plate();
// translate([0,  580, 0]) back_feet_3();
// translate([0,  680, 0]) back_feet_2();
// translate([0,  780, 0]) back_feet_1();
// translate([0,  820, 0]) back_feet_0();

// bottom_plate(12);
// middle_plate(13);
// middle_plate(14);
// switch_plate(15);
// second_plate(14);
// second_plate(13);
// top_plate(12);
// back_feet_3();
// back_feet_2();
// back_feet_1();
// back_feet_0();