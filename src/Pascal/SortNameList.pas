{ 12.10 }
program SortNameList;

uses	Strings,
	Matrix2D,
	SysUtils;

var
	{ F: file of string; }
	F: text;
	S: string;
	NameDB: TStringDynArray;
	Names: TStringDynArray;
	name: string;
	i: integer;

{ Ideally this would be a procedure,
  but for unknown reason it doesn't work this way. }
function ArrayInsert(A: TStringDynArray; idx: integer; S: string): TStringDynArray;
var
	i: integer;
begin
	SetLength(A, Length(A)+1);
	for i := Length(A)-2 downto idx do
		A[i+1] := A[i];
	A[idx] := S;
	ArrayInsert := A;
end;

begin
	{ assign(F, 'family_names_list_win.txt'); }
	{ reset(F); }
	{ while not eof(F) do }
	{ begin }
		{ read(F, S); }
		{ writeln(S); }
	{ end; }
	{ close(F); }

	SetLength(NameDB, 5);
	NameDB[0] := 'Smith John';
	NameDB[1] := 'Chekhov anton Pavlovich';
	NameDB[2] := 'carl cagan';
	NameDB[3] := 'Gates bill';
	NameDB[4] := 'Zorge Richard';

	SetLength(Names, 1);
	Names[0] := NameDB[0];

	for name in Copy(NameDB, 1, 4) do
	begin
		CapitalizeFirstWords(name);
		for i := 0 to Length(Names)-1 do
			if Precedes(name, Names[i]) then
			begin
				Names := ArrayInsert(Names, i, name);
				break;
			end;
		if Names[i] <> name then { not inserted }
			Names := ArrayInsert(Names, i+1, name);
	end;

	for i:=Low(Names) to High(Names) do
	begin
		write(Names[i]);
		writeln();
	end;
		
end.
