program FindLongestCommonSubstring;

{ TODO: Variable names could be better }

uses
	Math;

const
	PUNCTWSCH = '!@#$%^&*()_+-=`~<>,./?:;\|{}[]" ';

type
	ChSet = set of char;

var
	PunctWss: ChSet;
	S1: string = 'aabc!,dza  bzb$ cdef';
	S2: string = '...zbda cabdbcdefcbcE';
	LongestSubstr: string;
	i, j, k: integer;

procedure MakeSet(var Ss: ChSet; T: string);
var
	i: integer;
begin
	for i:=1 to Length(T) do
		Include(Ss, T[i]);
end;

function Preprocess(S: string; Ss: ChSet): string;
var
	T: string = '';
	i: integer;
begin
	for i:=1 to Length(S) do
		if not (S[i] in Ss) then
		begin
			SetLength(T, Length(T)+1);
			T[Length(T)] := S[i];
		end;
	Preprocess := T;
end;

begin
	PunctWss := [];
	MakeSet(PunctWss, PUNCTWSCH);
	LongestSubstr := '';

	writeln('Initial strings: ');
	writeln(S1);
	writeln(S2);
	writeln();

	S1 := Preprocess(S1, PunctWss);
	S2 := Preprocess(S2, PunctWss);
	writeln('Preprocessed strings: ');
	writeln(S1);
	writeln(S2);
	writeln();

	for i:=1 to Length(S1) do
		for j:=1 to Length(S2) do
		begin
			k := 0;
			while k <= min(Length(S1)-i, Length(S2)-j) do
			begin
				{ write(S1[i+k], ' ? ', S2[j+k], ', '); }
				if S1[i+k] <> S2[j+k] then
					break;
				Inc(k);
			end;
			if k > Length(LongestSubstr) then
				LongestSubstr := Copy(S1, i, k);
		end;
	
	writeln('Longest matching substring: ', LongestSubstr);
end.
