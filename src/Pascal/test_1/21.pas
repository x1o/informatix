program FixSpaces;


var
	i: integer;
	S: string = 'abc defg h,ijk;lmn op(qrst)uv/w.';
	S_fixed: string;
	whitespaces, chs_pre, chs_post: set of char;


procedure AppendS(var S: string; ch: char);
var
	l: integer;
begin
	l := Length(S);
	SetLength(S, l+1);
	S[l+1] := ch;
end;


begin
	chs_pre := ['(', '[', '{', '/'];
	chs_post := ['.', ',', ';', ':', '?', ')', ']', '}'];
	whitespaces := [' ', #9, #10];
	S_fixed := '';
	i := 1;
	{ Perhaps factoring out AppendS(S_fixed, S[i]) is possible }
	for i:=1 to Length(S) do
		if S[i] in chs_pre then
		begin
			if not (S[i-1] in whitespaces) then
				AppendS(S_fixed, ' ');
			AppendS(S_fixed, S[i]);
		end
		else if S[i] in chs_post then
			if not (S[i+1] in whitespaces) then
			begin
				AppendS(S_fixed, S[i]);
				AppendS(S_fixed, ' ');
			end
			else
				AppendS(S_fixed, S[i])
		else
			AppendS(S_fixed, S[i]);
	writeln(S);
	writeln(S_fixed);
end.
