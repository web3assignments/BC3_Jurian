## `Buffer`






### `init(struct Buffer.buffer _buf, uint256 _capacity)` (internal)





### `append(struct Buffer.buffer _buf, bytes _data) → struct Buffer.buffer _buffer` (internal)



Appends a byte array to the end of the buffer. Resizes if doing so
     would exceed the capacity of the buffer.


### `append(struct Buffer.buffer _buf, uint8 _data)` (internal)




Appends a byte to the end of the buffer. Resizes if doing so would
exceed the capacity of the buffer.


### `appendInt(struct Buffer.buffer _buf, uint256 _data, uint256 _len) → struct Buffer.buffer _buffer` (internal)




Appends a byte to the end of the buffer. Resizes if doing so would
exceed the capacity of the buffer.



