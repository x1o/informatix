var
	X: set of 1..255;
	i: integer;

begin
	X := [1, 4, 5];
	writeln(1 in X);
	writeln(2 in X);
	X := [2] + X;
	writeln(2 in X);
	for i:=1 to 300 do
		X := X + [i];
	writeln(299 in X);
end.
