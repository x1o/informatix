{ 12.10 }
program SortNameList;

uses
	Strings,
	Matrix2D,
	SysUtils;

const
	input_fname = '../../data/namelist.txt';
	
var
	f: textfile;
	S: string;
	NameDB: TStringDynArray;
	Names: TStringDynArray;
	name: string;
	i, l: integer;

{ Ideally this would be a procedure,
  but for an unknown reason it doesn't work this way. }
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
	SetLength(NameDB, 0);

	assign(f, input_fname);
	reset(f);
	while not(eof(f)) do
	begin
		readln(f, S);
		l := Length(NameDB);
		SetLength(NameDB, l+1);
		NameDB[l] := S;
	end;
	close(f);

	SetLength(Names, 1);
	Names[0] := NameDB[0];

	for name in Copy(NameDB, 1, Length(NameDB)) do
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
