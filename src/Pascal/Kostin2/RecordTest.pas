type
	Point = record
		case UsePolar: boolean of
		False: (x, y, z: real);
		True: (r, theta: real);
	end;

var
	p: Point;

begin
	{ what what what }
	p.UsePolar := True;
	p.r := 1.5;
	p.z := 3.5;
	writeln(p.r);
	writeln(p.z);
	p.UsePolar := False;
	p.theta := 2.5;
	writeln(p.theta);
	writeln(p.z);
end.
