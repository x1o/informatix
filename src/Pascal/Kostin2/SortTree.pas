program dersort;

type
	ref = ^yz;
	yz = record
		i: integer;
		l, r: ref
	end;

var
	x: ref;

procedure pd(var x:ref);
var
	z, y, y1: ref;
	a: integer;
begin
	read(a);
	if a <> 0 then
	begin
		new(x);
		x^.i := a;
		x^.l := nil;
		x^.r := nil;
		read(a);
		while a<>0 do
		begin
			y := x;
			new(z);
			z^.i := a;
			z^.l := nil;
			z^.r := nil;
			while y <> nil do
			begin
				y1 := y;
				if a < y^.i then
					y:=y^.l
				else
					y:=y^.r
			end;
			if a < y1^.i then
				y1^.l := z
			else
				y1^.r := z;
			read(a)
		end
	end
end;

procedure cod(var x:ref);
begin
	if x <> nil then 
	begin
		cod(x^.l);
		write(x^.i:3);
		cod(x^.r)
	end
end;

begin
	pd(x);
	cod(x)
end.

