program Polygon;

uses
	Graph;

var
	gd, gm, n, i, x_c, y_c, r: integer; 
	phi: real;
	pt: PointType;

begin
	gd := detect;
	InitGraph(gd, gm, ''); 

	writeln('Corrdinates of the center of the polygon: ');
	write('X = ');
	read(x_c);
	write('Y = ');
	read(y_c);
	write('Number of vertices of the polygon: ');
	read(n);
	write('Radius (100 is fine): ');
	read(r);
	{ n := 8; }
	{ r := 100; }
	{ x_c := GetMaxX div 2; }
	{ y_c := GetMaxY div 2; }

	{ PutPixel(x_c, y_c, white); }

	phi := (360 / n) * pi / 180;

	pt.x := x_c + Round(r * cos(0));
	pt.y := y_c + Round(r * sin(0));

	MoveTo(pt.x, pt.y);

	for i:=1 to n do
	begin
		pt.x := x_c + Round(r * cos(phi * i));
		pt.y := y_c + Round(r * sin(phi * i));
		LineTo(pt.x, pt.y);
	end;

	Randomize();
	SetFillStyle(SolidFill, Random(15));
	FloodFill(x_c, y_c, white);

	readln();
	readln();	{ TWO is required for a certain reason }
	CloseGraph;
end.
