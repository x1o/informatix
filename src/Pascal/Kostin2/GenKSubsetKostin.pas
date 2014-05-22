program GenKSubset;

const
	n = 6;
	k = 4;

var
	s: array [1..k] of 1..n;
	i, p: integer;

begin
	for i:=1 to k do
		s[i] := i;
	p := k;
	while p >= 1 do
	begin
		for i:=1 to k do
			write(s[i]);
		writeln();
		if s[k] = n then
			p := p - 1
		else
			p := k;
		if p >= 1 then
		begin
			s[p] := s[p] + 1;
			for i:=p+1 to k do
				s[i] := s[i-1]+1;
		end;
	end;
end.
