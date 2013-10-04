program TranslateEng;

const
	CAP_START = 65;
	CAP_END = 90;
	SMALL_START = 97;
	SMALL_END = 122;

var
	S: string = 'Hello, this is a sample text in English.';
	S2: string = 'AB*Z';
	S3: string = 'ab*z';

function TranslateString(S: string; offset: integer): string;
var
	i, ch_dec: integer;
begin
	for i:=1 to Length(S) do
	begin
		ch_dec := Ord(S[i]);
		{ Slightly repetitive, but making it a separate function
		wouldn't be too wise either; we just don't bother }
		if (ch_dec >= CAP_START) and (ch_dec <= CAP_END) then
		begin
			write(S[i], ' -> ');
			S[i] :=	Chr(
				(ch_dec + offset - CAP_START) mod
				(CAP_END - CAP_START + 1) +
				CAP_START
			);
			writeln(S[i]);
		end
		else if (ch_dec >= SMALL_START) and (ch_dec <= SMALL_END) then
		begin
			write(S[i], ' -> ');
			S[i] :=	Chr(
				(ch_dec + offset - SMALL_START) mod
				(SMALL_END - SMALL_START + 1) +
				SMALL_START
			);
			writeln(S[i]);
		end;
	end;

	TranslateString := S;
end;

begin
	writeln(TranslateString(S, 2));
end.
