#include <stdio.h>
#include <stdlib.h>

// ========================================================
// Definitions
// ========================================================

int next(char* buffer, int n);
void next_array(char* buffer, int n, int* arr, int m);
int next_int(char* buffer, int n);
double next_float(char* buffer, int n);
int next_line(char* buffer, int n);
void next_tuple(char* buffer, int n, int* tuple);

// ========================================================
// Solution
// ========================================================

int main() {
    printf("Hello, World!\n");
    return 0;
}

// ========================================================
// Helpers
// ========================================================

inline int next(char* buffer, int n) {
    int i = 0;
    while (i < n) {
        char ch = getchar();
        if (ch == EOF) {
            fprintf(stderr, "Reached EOF when reading input\n");
            exit(1);
        }
        buffer[i++] = ch;
        if (ch == ' ' || ch == '\n' || ch == '\0') break;
    }
    buffer[i] = '\0';
    return i;
}

inline void next_array(char* buffer, int n, int* arr, int m) {
    for (int i = 0; i < m; i++) {
        int bytes_read = next(buffer, n);
        arr[i] = atoi(buffer);
    }
}

inline int next_int(char* buffer, int n) {
    int bytes_read = next_line(buffer, n);
    return atoi(buffer);
}

inline double next_float(char* buffer, int n) {
    int bytes_read = next_line(buffer, n);
    return atof(buffer);
}

inline int next_line(char* buffer, int n) {
    char* input = fgets(buffer, n, stdin);
    if (!input) {
        fprintf(stderr, "Error reading input\n");
        exit(1);
    }

    int i = 0;
    while (i < n && buffer[i] != '\n' && buffer[i] != '\0') i++;

    if (i == n) {
        fprintf(stderr, "Reached EOF when reading input");
        exit(1);
    }

    if (buffer[i] == '\n') buffer[i] = '\0';

    return i;
}

inline void next_tuple(char* buffer, int n, int* tuple) {
    next_array(buffer, n, tuple, 2);
}
