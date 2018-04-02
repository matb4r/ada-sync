with text_io;
use text_io;

procedure pc_n_select2 is

	task buffer is
		entry insert(item : in integer);
		entry remove(item : out integer);
	end buffer;

	task body buffer is
		buf : array (0..4) of integer;
		ptr : integer := 0;
	begin
		loop
			select
				when ptr < 5 => accept insert(item : in integer) do
					buf(ptr) := item;
					ptr := ptr + 1;
				end;
			or
				when ptr > 0 => accept remove(item : out integer) do
					ptr := ptr - 1;
					item := buf(ptr);
				end;
			end select;
		end loop;
	end buffer;

	task producer;
	task body producer is
		item : integer := 0;
	begin
		loop
			buffer.insert(item);
			put_line("inserted" & item'img);
			item := item + 1;
		end loop;
	end producer;

	task consumer;
	task body consumer is
		item : integer;
	begin
		loop
			buffer.remove(item);
			put_line("removed" & item'img);
		end loop;
	end consumer;

begin
	null;
end pc_n_select2;
