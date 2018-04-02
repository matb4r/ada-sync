with text_io;
use text_io;

procedure pc_n_ob is
	type bufType is array(integer range 0..4) of integer;

	protected buffer is
		entry insert(item : in integer);
		entry remove(item : out integer);
	private
		buf : bufType;
		ptr : integer := 0;
	end buffer;

	protected body buffer is
		entry insert(item : in integer) when ptr < 5 is
		begin
			buf(ptr) := item;
			put_line("inserted at " & ptr'img & " - " & buf(ptr)'img);
			ptr := ptr + 1;
		end insert;

		entry remove(item : out integer) when ptr > 0 is
		begin
			ptr := ptr - 1;
			item := buf(ptr);
			put_line("removed at " & ptr'img & " - " & buf(ptr)'img);
		end remove;
	end buffer;

	task producer;
	task body producer is
		item : integer := 0;
	begin
		loop
			buffer.insert(item);
			item := item + 1;
			delay 0.5;
		end loop;
	end producer;

	task consumer;
		item_out : integer;
	task body consumer is
	begin
		loop
			buffer.remove(item_out);
			delay 0.5;
		end loop;
	end consumer;

begin
	null;
end pc_n_ob;
