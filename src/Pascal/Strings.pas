unit Strings;

interface

type
	TStringDynArray = array of string;

function CountChar(S: string; TargChar: char): integer;
function Split(S: string; sep: char = ' '): TStringDynArray;
function Partition(S: string; PLen: integer): TStringDynArray;
function CountSubstring(S: string; substr: string): integer;
{ function StrToNum(S: string): Extended; }
function Hd(S: string): char;
function Tl(S: string): string;
function Precedes(S: string; T: string): boolean;
procedure CapitalizeFirstWords(var S: string);



implementation

uses math;

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

{ function StrToNum(S: string): Extended; }
{ var }
	{ i: integer; }
	{ n: Extended; }
{ begin }
	{ n := 0; }
	
	{ for i := 0 to Length(S)-1 do }
		{ n := n + (ord(lowercase(S[Length(S)-i])) - ord(' ') + 1) * power(127 - ord(' ') + 1, i); }

	{ StrToNum := n; }
{ end; }

function Hd(S: string): char;
begin
	Hd := S[1];
end;

function Tl(S: string): string;
begin
	Tl := Copy(S, 2, Length(S));
end;

function Precedes(S: string; T: string): boolean;
begin
	if (Length(T) = 0) or (ord(lowercase(Hd(S))) > ord(lowercase(Hd(T)))) then
		exit(False);
	if (Length(S) = 0) or (ord(lowercase(Hd(S))) < ord(lowercase(Hd(T)))) then
		exit(True);
	Precedes := Precedes(Tl(S), Tl(T));
end;

procedure CapitalizeFirstWords(var S: string);
var
	i: integer;
begin
	S := UpperCase(Hd(S)) + Tl(S);
	i := 1;
	while i < Length(S) do
	begin
		if (S[i] = ' ') then
		begin
			S := Copy(S, 1, i) + UpperCase(S[i+1]) + Copy(S, i+2, Length(S));
			i := i + 1;
		end;
		i := i + 1;
	end;
end;

end.
