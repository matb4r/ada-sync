with text_io;
use text_io;

procedure procons is

	task Buffer is
		entry put(item : in integer);
		entry get(item : out integer);
	end Buffer;

	task body Buffer is
		buf : array(0..4) of integer;
		i : integer := 0;
	begin
		loop
			select
				when i < 5 => accept put(item : in integer) do
					buf(i) := item;
					put_line("put[" & i'img & "]:" & item'img);
					i := i + 1;
					delay 0.5;
				end;
			or
				when i > 0 => accept get(item : out integer) do
					i := i - 1;
					item := buf(i);
					put_line("   get[" & i'img & "]:" & item'img);
					delay 0.5;
				end;
			end select;
		end loop;
	end Buffer;

	task pro;
	task body pro is
		item : integer := 0;
	begin
		loop
			Buffer.put(item);
			item := item + 1;
		end loop;
	end pro;

	task cons;
	task body cons is
		item : integer;
	begin
		loop
			Buffer.get(item);
			delay 3.0;
		end loop;
	end cons;

begin
	null;
end procons;
