#include <iostream>

using namespace std;

extern "C" void procedure_for_c_plus_plus();

int main()
{
    procedure_for_c_plus_plus();
    return 0;
}