{ (c) mostly by Dima S. }

program RLE;

var 
	s: string;

procedure Encode(s: string);
var
	reps, i: integer;
begin
	reps := 1;
	for i:=1 to Length(s)-1 do
	begin
		if s[i] = s[i+1] then
			reps := reps + 1;
		if (s[i] <> s[i+1]) or (i = length(s)-1) then
		begin
			if i = Length(s)-1 then
			begin
				if s[length(s)] = s[length(s)-1] then
					write(s[i], reps + 1)
				else
					write(s[i], reps, s[i+1], 1);
			end
			else
			begin
				write(s[i], reps);
				reps := 1;
			end;
		end;
	end;
	writeln();
end;

begin
	writeln('String to encode:');
	readln(s);
	writeln('Encoded string:');
	Encode(s);
end.
