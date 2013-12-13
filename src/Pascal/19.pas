program CountWordsSameBeginEnd;

var
	S: string = 'abc abca bcde edcbe';
	start_c: char;
	i, acc: integer;

begin
	writeln(S);

	if Length(S) < 2 then
	begin
		writeln('The length of the string must be greater than or equal to two.');
		exit();
	end;

	acc := 0;
	i := 2;

	start_c := S[1];
	while i <= Length(S) do
	begin
		if (S[i] = ' ') then
		begin
			if S[i-1] = start_c then
				Inc(acc);
			Inc(i);
			start_c := S[i];
		end;
		Inc(i);
	end;

	{ checking the last word }
	{ XXX: ugly }
	if S[i-1] = start_c then
		Inc(acc);

	writeln(acc, ' word(s) have matching initial and final characters');
end.
