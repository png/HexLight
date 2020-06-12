module hexagon(r,x,y,h){
    polygon(points=[
        [(r+x),(r*(tan(30)))+y],
        [x,(r*(2/sqrt(3)))+y],
        [-r+x,(r*(tan(30)))+y],
        [-r+x,-(r*(tan(30)))+y],
        [x,-(r*(2/sqrt(3)))+y], 
        [r+x,-(r*(tan(30)))+y]]);
}

h_total = 2.5;
h_lip = .5;
r_max = 10;
r_diff = .25;
r_lip = 9.5;
b_height = .5;
b_width = 2;

module case(){
    union() difference(){
        linear_extrude(h_total){
            union() difference() {
                hexagon(r_max,0,0);
                hexagon(r_max-r_diff,0,0);
            };
        };
        backplate();
    }

    translate([0,0,h_total-h_lip]){
        linear_extrude(h_lip){
            union() difference() {
                hexagon(r_max,0,0);
                hexagon(r_lip,0,0);
            };
        };
    }
}
module backplate(){
    translate([0,0,b_height/2]){
        union() difference() {
            for ( i = [0 : 2] ){
                rotate( (i * 120)+90)
                cube([b_width, 2*r_max, b_height], true);
            };
            cylinder(h = (b_height*2)+10, r = b_width/2, center = true, $fn=10);
        };
    };
}

case();

//translate([2*r_max+1, 0, 0]){
//    backplate();
//}

backplate();