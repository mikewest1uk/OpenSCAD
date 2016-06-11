sf = .045;

module BigBen(x,y,z) {
	z1=z/2;
	translate([x/2,y/2, 0]) {
		translate([0,0,z1/2]) {
			cube([x,y,z1],center=true);
			z2=x*1.2;
			translate([0,0,z2/2 + z1/2]) {
				cube(z2,center=true);
				rotate([0,0,0]) BigBenClock(x*2/3/2,z2/2);
				rotate([0,0,90]) BigBenClock(x*2/3/2,z2/2);
				rotate([0,0,180]) BigBenClock(x*2/3/2,z2/2);
				rotate([0,0,270]) BigBenClock(x*2/3/2,z2/2);
				z3=z2/4;
				translate([0,0,z2/2 + z3/2]) {
					cube([x,y,z3],center=true);
					z4=z2/2;
					translate([0,0,z3/2 + z4/2]) {
					rotate([0,0,45])	
						cylinder(z4,x/2*sqrt(2),x/4*sqrt(2),$fn=4,center=true);
						z5=z4*2/3;
						translate([0,0,z4/2+z5/2]) {
							cube([x/2,x/2,z5],center=true);
							z6=z5*2;
							translate([0,0,z5/2 + z6/2]) {
							rotate([0,0,45])	
								cylinder(z6,x/4*sqrt(2),1,$fn=4,center=true);
							}
						}
					}
				}								
			}	
		}
	}
}

module BigBenClock(r,d){
	translate([0,d,0])
	rotate([-90,0,0])
		Clock(r);	
}

module Clock(r) {
	hl=r*2/3;
	hy=hl/10;
	hz=hy*1.5;
	cfy=hy;

	cylinder(cfy,r,r, $fn=20);
	translate([0,0,0]) {
		cube([hl,hy,hz]);
		rotate([0,0,270])	
			cube([hl*1.1,hy,hz]);

	}
}

module Window(x,y,z) {	
	barX=(z-y)/20;
	gapX=x-y-y;
	translate([0,0,z-y])
		cube([x,y,y]);
	cube([y,y,z-y]);
	translate([x-y,0,0])
		cube([y,y,z-y]);
	translate([y,y/2,(z-y)/2])
		cube([gapX,barX,barX]);
	translate([y+gapX/3-barX/2,y/2,0])
		cube([barX,barX,z-y]);
	translate([y+gapX/3*2-barX/2,y/2,0])
		cube([barX,barX,z-y]);
}

module wall(x,y,z, extraZ) {
	cube([x,y,y]);
	translate([x-y,0,y])
		cube([y,y,z+extraZ]);
	translate([0,0,y])
		Window(x-y,y,(z-y)/2);
	translate([0,0,((z-y)/2)+y])
		Window(x-y,y,(z-y)/2);
	translate([x-y/2,y/2,z+extraZ])
		cylinder(y*2,y/2,0);

}		
module wallSection(x,y,z,count) {
	for(i=[0:count-1]) {
		translate([i*x,0,0]) wall(x,y,z, y*3);
	}
}

module tower(x,y,z) {
	twy=11 * sf;
	twx=x-twy;
	extraZ = 6*twy;

	translate([twy,0,0]) wall(twx,twy,z, extraZ);
	translate([twx+twy,0,0]) rotate([0,0,90]) wall(twx,twy,z, extraZ);
	translate([twx,twx,0]) rotate([0,0,180]) wall(twx,twy,z, extraZ);
	translate([0,twx,0]) rotate([0,0,270]) wall(twx,twy,z, extraZ);
	translate([twy,twy,0]) cube([x-twy*2,y-twy*3,z]);
}


bbz=900 * sf ;
bbx=bbz/5;
bby=bbx;

translate([-20, -140, 0])
	cube([50, 150, bbz/100]);

translate([0,0,0])
	BigBen(bbx,bby,bbz);

wx=51 * sf;
wz=181 * sf;
wy=11 * sf;

translate([bbx,0,0])
	wallSection(wx,wy,wz,6);

tx=bbx*2/3;
ty=tx;
tz=wz*1.5;

vtx=tx*2;
vty=ty*2;
vtz=tz*2;

translate([6*wx+bbx,-ty/2,0]) {
	tower(tx,ty,tz);
	rotate([0,0,-90]) {
		translate([0,ty/2,0])
			wallSection(wx,wy,wz,3);
		translate([wx*3,0,0]) {
			tower(tx,ty,tz);
			translate([tx,0,0]) {
				wallSection(wx,wy,wz,12);
				translate([wx*12,0,0]) {
					tower(tx,ty,tz);
					translate([tx,0,0]) {
						wallSection(wx,wy,wz,11);
						translate([wx*11,0,0]) {
							tower(tx,ty,tz);
							translate([tx,0,0]) {
								wallSection(wx,wy,wz,14);
								translate([wx*14,0,0]) {
									tower(tx,ty,tz);
									translate([tx,ty/2,0]) {
										wallSection(wx,wy,wz,3);
										translate([wx*3,-ty/2,0]) {
											tower(tx,ty,tz);
											rotate([0,0,-90])
											translate([0,tx-wy,0]) {
												wallSection(wx,wy,wz,8);
													translate([wx*8,-vty/2,0]) {
														tower(vtx,vty,vtz);
														rotate([0,0,-90])
														translate([0,vtx-wy,0]) {
															wallSection(wx,wy,wz,14);
															rotate([0,0,90])
															translate([0,-wx*14,0]) {
																wallSection(wx,wy,wz,4);
																rotate([0,0,-90])
																translate([0,wx*4-wy,0]) {
																	wallSection(wx,wy,wz,19);
																	rotate([0,0,-90])
																	translate([0,wx*19-wy,0]) {
																		wallSection(wx,wy,wz,7);
																		translate([wx*7,0,0]) {
																			tower(tx,ty,tz);
																			rotate([0,0,90])
																			translate([tx-wy,-wy,0]) {
																				wallSection(wx,wy,wz,19);
																			}
																		}
																	}
																}
															}

														}
													}
											}

										}	
										
									}
								}
							}							
						}

					}

				}

			}

		}

	}
}

