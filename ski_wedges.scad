t1 = 2.25;
t2 = 3.6;

width=76;
length=200;
gap=1;

module wedge(left_thickness, right_thickness, width=76.0, length=300.0){
	diff_thick = right_thickness - left_thickness;
	echo(diff_thick);
	degrees = atan(diff_thick / width);
	echo(degrees);
	difference(){
		cube([length,width,right_thickness], center=true);
		translate([0,0,0.5 * right_thickness]) rotate([degrees,0,0]) {cube([length * 1.1,width * 1.4,right_thickness], center=true);}
	}	
}

union(){
	translate([0,(width  / 2),0]) {
		union(){
			wedge(1, 1 + t1, width, length);
			translate([0,width + gap,0]) {wedge(1, 1 + t1, width, length);};
		}
	}
	translate([0,-((width * 1.5) + (2 * gap)),0]) {
		union(){
			wedge(1, 1 + t2, width, length);
			translate([0,width + gap,0]) {wedge(1, 1 + t2, width, length);};
		}
	}
}
