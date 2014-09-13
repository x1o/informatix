program GenKSubset;

const
	n = 5;
	k = 2;

type
	KSet = array [1..k] of 1..n;

var
	s: KSet;
	i, p: integer;

procedure PrintS(s: KSet);
var
	i: integer;
begin
	for i:=1 to k do
		write(s[i]);
	writeln();
end;

begin
	for i:=1 to k do
		s[i] := i;
	p := k;

	PrintS(s);

	while p >= 1 do
	begin
		if s[p] < n - (k - p) then
		begin
			Inc(s[p], 1);
			while p < k do
			begin
				Inc(p, 1);
				s[p] := s[p-1] + 1;
			end;
			PrintS(s);
		end
		else
			Dec(p, 1);
	end;
end.
