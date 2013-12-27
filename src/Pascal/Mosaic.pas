program Mosaic;

uses
	Graph,
	Math;

var
	gd, gm, x_c, y_c, n, dx, dy, i, j: integer; 
	r: real;

procedure DrawPolygon(x_c, y_c, n: integer; r: real);
var
	i: integer;
	phi: real;
	pt: PointType;
begin
	phi := (360 / n) * pi / 180;

	pt.x := x_c + Round(r * cos(pi/2));
	pt.y := y_c + Round(r * sin(pi/2));

	MoveTo(pt.x, pt.y);

	for i:=1 to n do
	begin
		pt.x := x_c + Round(r * cos(phi * i + pi/2));
		pt.y := y_c + Round(r * sin(phi * i + pi/2));
		LineTo(pt.x, pt.y);
	end;

	Randomize();
	{ if GetMaxX - x_c < 0 then }
		{ x_c := x_c - Round(r * cos(((360 / n) * pi / 180)/2)) + 1; }
	{ if GetMaxY - y_c }
	SetFillStyle(SolidFill, Random(15));
	FloodFill(x_c, y_c, white);
end;

begin
	gd := detect;
	InitGraph(gd, gm, ''); 
	x_c := 300;
	y_c := 200;
	n := 6;
	r := 100;
	dx := Round(r * cos(((360 / n) * pi / 180)/2));
	dy := Round(r + sqrt(Power(r, 2) - Power(dx, 2)));

	x_c := 0;
	y_c := 0;
	i := 0;
	j := 0;
	{ while y_c + dy/2*j <= GetMaxY do }
	while y_c + dy*j <= GetMaxY do
	begin
		{ while x_c + dx*i <= GetMaxX do }
		while x_c + dx*2*i <= GetMaxX do
		begin
			DrawPolygon(x_c + dx*2*i + dx*(j mod 2), y_c + dy*j, n, r);
			i := i + 1;
		end;
		i := 0;
		j := j + 1;
	end;

	{ DrawPolygon(x_c + dx, y_c + dy, n, r); }
	readln();
end.
