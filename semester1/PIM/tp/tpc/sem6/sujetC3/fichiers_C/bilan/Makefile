# Définition des Variables (à compléter)
CC = c99
CFLAGS = -Wextra -pedantic -c 
LDFLAGS = 
EXE = test_file exemple_file

# Règles (à compléter avec des variables automatiques)
all: $(EXE)

test_file: test_file.o file.o
	$(CC) $(LDFLAGS) $^ -o $@


exemple_file: exemple_file.o file.o
	$(CC) $(LDFLAGS) $^ -o $@

depend:
	makedepend *.c

clean:
	rm *.o test_file exemple_file

.PHONY: clean all makedepend
# DO NOT DELETE

exemple_file.o: file.h /usr/include/stdio.h /usr/include/stdlib.h
exemple_file.o: /usr/include/assert.h /usr/include/features.h
exemple_file.o: /usr/include/stdc-predef.h
file.o: /usr/include/malloc.h /usr/include/features.h
file.o: /usr/include/stdc-predef.h /usr/include/stdio.h /usr/include/assert.h
file.o: file.h
test_file.o: file.h /usr/include/stdlib.h /usr/include/assert.h
test_file.o: /usr/include/features.h /usr/include/stdc-predef.h