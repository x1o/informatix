program GenGrayCodesIterative;

{ XXX: how does it work after all? }

const
	n = 3;

var
	s: array [1..n] of 0..1;
	i, j, k, p: integer;

begin
	for k:=1 to n do
		s[k] := 0;
	i := 0;
	repeat
		for k:=1 to n do
			write(s[k]);
		writeln();
		i := i + 1;
		p := 1;
		j := i;
		while j mod 2 = 0 do
		begin
			j := j div 2;
			p := p + 1;
		end;
		if p <= n then
			s[p] := 1 - s[p];
	until (p > n);
end.
