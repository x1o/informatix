unit Strings;

interface

type
	TStringDynArray = array of string;

function CountChar(S: string; TargChar: char): integer;
function Split(S: string; sep: char = ' '): TStringDynArray;
function Partition(S: string; PLen: integer): TStringDynArray;
function CountSubstring(S: string; substr: string): integer;



implementation

function CountChar(S: string; TargChar: char = ' '): integer;
var
	counter: integer = 0;
	c: char;
begin
	for c in S do
		if (c = TargChar) then
			Inc(counter);
	CountChar := counter;
end;

function Split(S: string; sep: char = ' '): TStringDynArray;
var
	Res: TStringDynArray;
	i, j, cnt: integer;
begin
	cnt := 0;
	{ j := Low(S); }
	j := 1;
	SetLength(Res, CountChar(S, sep) + 1);
	{ for i := Low(S) to Length(S) do }
	for i := 1 to Length(S) do
		if (S[i] = sep) then
		begin
			Res[cnt] := WideString(S[j..(i-1)]);
			j := i+1;
			Inc(cnt);
		end;
	Res[cnt] := WideString(S[j..i]); { at the end of the string }
	Split := Res;
end;

function Partition(S: string; PLen: integer): TStringDynArray;
var
	Res: TStringDynArray;
	i, SLen, cnt:  integer;
begin
	cnt := 0;
	i := 1;
	SLen := Length(S);
	SetLength(Res, (SLen div PLen) + 1);
	while ((i + PLen) < SLen) do
	begin
		Res[cnt] := WideString(S[i..(i+PLen-1)]);
		Inc(cnt);
		i := i + PLen;
	end;
	Res[cnt] := WideString(S[i..SLen]);
	Partition := Res;
end;

{ non-overlapping! }
function CountSubstring(S: string; substr: string): integer;
var
	cnt: integer = 0;
	wrd: string;
begin
	for wrd in Partition(S, Length(substr)) do
		if (wrd = substr) then
			Inc(cnt);
	CountSubstring := cnt;
end;

end.
