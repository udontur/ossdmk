#include <iomanip>
#include <iostream>

using namespace std;

int main(int argc, char* argv[]) {
    
    int numberOfItems;
    cout << "Number of items? ";
    cin >> numberOfItems;
    
    long long mark[numberOfItems];
    cout << "Enter the marks: \n";
    cout << "\033[90m==> \033[39m";
    for (int i = 0; i < numberOfItems; i++) {
        double markInput;
        cin >> markInput;
        mark[i] = static_cast<long long>(markInput * 1000000);
    }

    cout << "Enter the denominators: \n";
    cout << "\033[90m==> \033[39m";
    for (int i = 0; i < numberOfItems; i++) {
        long long denominatorInput;
        cin >> denominatorInput;
        mark[i] /= denominatorInput;
    }

    long long weight[numberOfItems], totalWeight = 0;
    cout << "Enter the weights: \n";
    cout << "\033[90m==> \033[39m";
    for (int i = 0; i < numberOfItems; i++) {
        double weightInput;
        cin >> weightInput;
        totalWeight += weightInput * 10;
        weight[i] = weightInput * 10000000;
    }

    cout << "\n";

    long long exactMarkProcess = 0;
    for (int i = 0; i < numberOfItems; i++) {
        long long sectionMark = mark[i] * (weight[i] / totalWeight);
        exactMarkProcess += sectionMark / 1000000;
    }

    if (exactMarkProcess % 10 >= 5)
        exactMarkProcess += 10;
    exactMarkProcess /= 10;

    int finalMark = exactMarkProcess;
    finalMark /= 100;
    if (finalMark % 10 >= 5)
        finalMark += 10;
    finalMark /= 10;

    double exactMark = static_cast<double>(exactMarkProcess);
    exactMark /= 1000.0;

    cout << "\033[92mFinal Mark: " << finalMark << "\033[39m\n";
    cout << fixed << setprecision(3);
    cout << "\033[37mExact Mark: " << exactMark << "\033[39m\n";

    return 0;
    
}