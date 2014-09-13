program GenSetLexicographic;

{ Генерация всех подмножеств в лексикографическом порядке }

const
	n = 5;

var
	X: array [0..n] of 0..1;
	i, c: integer;

begin
	for i:=0 to n do
		X[i] := 0;
	while X[0] = 0 do
	begin
		for i:=1 to n do
			write(X[i]);
		writeln();
		i := n;
		while X[i] = 1 do
		begin
			X[i] := 0;
			Dec(i, 1);
		end;
		X[i] := 1;
	end;
end.
