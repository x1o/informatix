{ (c) mostly by Dima S. }

program LZW;

const
	N = 100;

var
	s: string;
	lz: array [1..N] of string;

procedure Encode(s: string);
var
	l1, i, j, k, tmp, max: integer;
	L: array [1..N] of string;
	a: string;
begin
	l1 := length(s);
	max := 1;
	i := 1;
	tmp := 1;
	for k := 1 to l1 do
	begin
		a := Copy(s, k, 1);
		for j := 1 to i do
		begin
			if (L[j] = a) then
			begin
				if (k + tmp <= l1) then
				begin
					a := Copy(s, k, 1 + tmp);
					tmp := tmp + 1;
				end
				else
					tmp := 0;
			end;
		end;
		if tmp >= max then
		begin
			max := tmp;
			L[i] := a;
			i := i + 1;
		end;
		tmp := 1;
	end;
	i := i - 1;
	for j := 1 to i do
		write(j:4, L[j]);
end;

begin
	writeln('String to encode:');
	readln(s);
	writeln('Encoded string:');
	Encode(s);
end.
