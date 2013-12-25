program LZ;

var
	s: string;

procedure Encode(s: string);
var
	k, km: string;
	a: array[1..100] of string;
	i, j, jm: integer;
	b: 0..1;
begin
	for i:=1 to 100 do
		a[i] := '';

	jm := 1;
	i := 1;
	k := '';
	b := 0;

	while i <= length(s) do
	begin
		km := k;
		k := k+s[i];
		b := 0;
		for j:=1 to jm do
			if a[j] = k then
			begin
				i := i+1;
				b := 1;
			end;
		if b = 0 then
		begin
			for j:=1 to jm do
				if a[j] = km then
					write(j, s[i], ' ');
			a[jm] := k;
			k := '';
			jm := jm + 1;
			i := i + 1;  
		end;
	end;

end;

begin 
	writeln('String to encode:');
	readln(s);
	writeln('Encoded string:');
	Encode(s);
end.
