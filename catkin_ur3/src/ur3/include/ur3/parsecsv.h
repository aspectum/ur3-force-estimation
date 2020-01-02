#include <string>
#include <vector>
#include <sstream> //istringstream
#include <iostream> // cout
#include <fstream> // ifstream
 
using namespace std;
//  https://waterprogramming.wordpress.com/2017/08/20/reading-csv-files-in-c/
/**
 * Reads csv file into table, exported as a vector of vector of doubles.
 * @param inputFileName input file name (full path).
 * @return data as vector of vector of doubles.
 */
vector<vector<double>> parsecsv(string inputFileName);