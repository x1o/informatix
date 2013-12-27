program Mosaic;

uses
	Graph,
	Math;

const
	n = 6;
	r = 70;
	x_c = 0;
	y_c = 0;

var
	gd, gm, dx, dy, i, j: integer; 

function CompPhi(n: integer): real;
begin
	exit((360 / n) * pi / 180);
end;

function CompDx(n: integer; r: real): integer;
begin
	exit(Round(r * cos(CompPhi(n)/2)));
end;

function CompDy(n: integer; r: real): integer;
begin
	exit(Round(r + sqrt(Power(r, 2) - Power(CompDx(n, r), 2))));
end;

procedure DrawPolygon(x_c, y_c, n: integer; r: real);
var
	i: integer;
	phi: real;
	pt: PointType;
begin
	phi := CompPhi(n);
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
	if (GetMaxX - x_c < 0) and (GetMaxY - y_c < 0) then
		exit();
	if GetMaxX - x_c < 0 then
		x_c := x_c - CompDx(n, r) + 1;
	if GetMaxY - y_c < 0 then
		y_c := y_c - CompDy(n, r) + 1;
	SetFillStyle(SolidFill, Random(15));
	FloodFill(x_c, y_c, white);
end;

begin
	gd := detect;
	InitGraph(gd, gm, ''); 

	dx := CompDx(n, r);
	dy := CompDy(n, r);

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

	readln();
end.
