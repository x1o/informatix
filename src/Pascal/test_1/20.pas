program FixBraces;

var
	// S: string = '(1+2*(4-(55-4)-(42+4*(9+2-4/(2+5))-3)))';
	S: string = '((()(())))';
	// {{[][()]}}
	S_fixed: string;
	i, lvl: integer;

begin
	SetLength(S_fixed, Length(S));
	lvl := 0;
	for i:=1 to Length(S) do
		case S[i] of
			'(': 
				begin
				Inc(lvl);
				if lvl = 1 then
					S_fixed[i] := '{'
				else if lvl = 2 then
					S_fixed[i] := '['
				else if lvl >= 3 then
					S_fixed[i] := S[i];
				end;
			')':
				begin
				if lvl = 1 then
					S_fixed[i] := '}'
				else if lvl = 2 then
					S_fixed[i] := ']'
				else if lvl >= 3 then
					S_fixed[i] := S[i];
				Dec(lvl);
				end;
			else
				S_fixed[i] := S[i];
		end;

	if lvl <> 0 then
	begin
		writeln('Parens mismatch by ', lvl);
		exit();
	end;

	writeln(S);
	writeln(S_fixed);
end.
