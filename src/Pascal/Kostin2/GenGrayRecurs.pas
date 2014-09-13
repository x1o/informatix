program GenGrayCodesRecursive;

const
	n = 2;

var
	s: array [1..n] of 0..1;
	i: integer;

procedure Gray(m: integer);
begin
	if m = 0 then
	begin
		for i:=1 to n do
			write(s[i]);
		writeln();
	end
	else
	begin
		Gray(m-1);
		s[m] := 1 - s[m];
		Gray(m-1);
	end;
end;

begin
	for i:=1 to n do
		s[i] := 0;
	Gray(n);
end.
