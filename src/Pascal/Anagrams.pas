{ 12.20 }
program Anagrams;

uses Strings;

var
	Words: TStringDynArray;
	Matched_ids: set of byte;
	i, j: integer;

begin
	SetLength(Words, 6);
	Words[0] := 'Hello';
	Words[1] := 'Queen';
	Words[2] := 'Drawer';
	Words[3] := 'Olleh';
	Words[4] := 'Reward';
	Words[5] := 'Fish';

	for i := 0 to length(Words)-1 do
		writeln(i, ': ', Words[i]);

	for i := 0 to Length(Words)-1 do
	begin
		if i in Matched_ids then
			continue;
		for j := i+1 to Length(Words)-1 do
		begin
			if j in Matched_ids then
				continue;
			if lowercase(Words[i]) = Reversed(lowercase(Words[j])) then
			begin
				writeln(Words[i], ' ~ ', Words[j]);
				Include(Matched_ids, j);
			end;
		end;
	end;
end.
