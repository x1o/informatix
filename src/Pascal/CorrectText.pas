{ 12.5 }
program CorrectText;

uses
	Strings;

const
	SEPS = [' ', '$', '#', '@'];
	LINE_WIDTH = 60;
	input_fname ='../../data/text_for_correction.txt';

var
	input_str: string;
	S, T: WideString;
	f: textfile;
	i, j: integer;

function GetNextWordIdx(S: WideString; start_i: integer): integer;
var
	i: integer;
begin
	for i:=start_i+1 to Length(S) do
		if S[i] in SEPS then
			exit(i);
	exit(i);
end;

function GetNextPhraseIdx(S: WideString; start_i: integer): integer;
var
	i: integer;
begin
	for i:=start_i+1 to Length(S) do
		if Copy(S, i, 2) = '. ' then
			exit(i+1);
	exit(i);
end;

function GetNextLineIdx(S: WideString; start_i: integer): integer;
var
	i: integer;
begin
	for i:=start_i to Length(S) do
		if S[i] = LineEnding then
			exit(i);
	exit(i+1);
end;

procedure AppendCh(var S: WideString; ch: char);
var
	l: integer;
begin
	l := Length(S);
	if l = 0 then
	begin
		SetLength(S, 1);
		S[1] := ch;
	end
	else
	begin
		SetLength(S, l+1);
		S[l+1] := ch;
	end;
end;

function WrapLine(S: WideString; width: integer):  WideString;
var
	i, j: integer;
begin
	i := 0;
	while i <= Length(S) do
		if i + width < Length(S) then
		begin
			for j := i + width downto i do
				if S[j] = ' ' then
				begin
					{ S[j] := #13; }
					S[j] := LineEnding;
					break;
				end;
			i := j + 1;
		end
		else
			exit(S);
	exit(S);
end;

begin
	{
	  $: indent the line
	  #: delete the next word
	  @: delete the next phrase
	}

	assign(f, input_fname);
	reset(f);

	S := '';
	while not eof(f) do 
	begin 
		readln(f, input_str); 
		if Length(S) = 0 then
			S := S + input_str
		else
			S := S + ' ' + input_str;
	end;

	close(f);

	T := '';
	i := 1;
	while i <= Length(S) do
		case S[i] of
			'$': 
				begin
					{ AppendCh(T, #13); }
					AppendCh(T, LineEnding);
					AppendCh(T, ' ');
					AppendCh(T, ' ');
					i := i + 1;
				end;
			'#': i := GetNextWordIdx(S, i);
			'@': i := GetNextPhraseIdx(S, i);
			else
				begin
					AppendCh(T, S[i]);
					i := i + 1;
				end;
		end;
	
	{ assign(f, Split(input_fname, '.')[0]+'_corrected.txt'); }
	assign(f, 'text_corrected.txt');
	rewrite(f);

	i := 1;
	while i <= Length(T) do
	begin
		j := GetNextLineIdx(T, i);
		writeln(f, WrapLine(Copy(T, i, j-i), LINE_WIDTH));
		i := j+1;
	end;

	close(f);
end.
