program LZW;

{ WARNING: No collision handling of the hash function }

const
	DICT_LEN = 10000;

type
	assoc_array = array [0..DICT_LEN-1] of integer;

function FNV1aHash(const s: AnsiString): LongWord;
var
    i: Integer;
const
    FNV_offset_basis = 2166136261;
    FNV_prime = 16777619;
begin
    Result := FNV_offset_basis;
    for i := 1 to Length(s) do
        Result := (Result xor Byte(s[i])) * FNV_prime;
end;

var
	s: string;

procedure add(var dict: assoc_array; key: string; value: integer);
begin
	dict[FNV1aHash(key) mod DICT_LEN] := value;
end;

function get(dict: assoc_array; key: string): integer;
begin
	exit(dict[FNV1aHash(key) mod DICT_LEN]);
end;

procedure Encode(s: string);
{ Ideally should be returning the encoded string and the corresponding dictionary }
var
	D: assoc_array;
	i, j, last_n: integer;
begin
	{ All entries in D are 0's by default }
	for i:=ord(' ') to ord('~') do
		add(D, char(i), i - ord(' '));

	last_n := i - ord(' ');

	i := 1;
	j := 2;
	while (i + j) <= Length(s)+1 do
	begin
		if get(D, Copy(s, i, j)) = 0 then
		begin
			write(get(D, Copy(s, i, j-1)), '(', Copy(s, i, j-1), ') ');
			Inc(last_n);
			add(D, Copy(s, i, j), last_n);
			i := i + j-1;
			j := 2;
		end
		else
			Inc(j);
	end;
	write(get(D, Copy(s, i, j)), '(', Copy(s, i, j), ') ');
	writeln();
end;

begin
	{ s := 'ABCABCABCABCABCABC'; }
	write('Input a string to compress: ');
	readln(s);
	Encode(s);
end.
