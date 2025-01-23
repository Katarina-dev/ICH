from typing import Optional
import pymysql
from tabulate import tabulate
from db_connect import db
from typing import Optional, Tuple, List

class MovieByPages:
    def __init__(self, request: str, params:Optional[list]=None, page_size: int = 10):
        """Initialization with basic parameters for pagination.

        Args:
            request (str): Basic SQL query (without LIMIT and OFFSET).
            params (Optional[list]): Parameters for the SQL query (default empty list).
            page_size (int): Number of entries on one page (default 10).
            """
        self.request = request  # Saving the basic SQL query
        self.params = params or []  # If no parameters are passed, create an empty list
        self.page_size = page_size  # Number of entries per page
        self.page = 1  # The first page (first by default)

    def get_data_by_pages(self) -> List[dict]:
        """Returns data with pagination (LIMIT and OFFSET).

        Returns:
            list: List of records retrieved from the database for the current page.
            """
        offset = (self.page - 1) * self.page_size  # Calculate offset based on current page
        page_request = self.request + " LIMIT %s OFFSET %s" # Add LIMIT and OFFSET to the original SQL query

        # Merge the original request parameters and pagination parameters
        request_params = self.params + [self.page_size, offset]

        try:
            # Execute a request with parameters through the db.mysql_request_select function
            return db.mysql_request_select(page_request, request_params)
        except pymysql.err.ProgrammingError as ex:
        # Check if the table with popular requests exists
            if ex.args[0] == 1146:
                print("Error: Table with popular requests not found.")
        except pymysql.Error as er:
            print(f'Database error: {er}: {er.args[1]}')
            return []

    def print_results(self) -> None:
        """Prints the results of the query with pagination via tabulate library.

           The method performs the following steps:
        1. Retrieves a list of results for the current page.
        2. Converts the list of dictionaries into a format compatible with `tabulate`.
        3. Extracts column headers from the result and displays the table.
        4. Prompts the user to either continue to the next page or quit the process.

        Pagination behavior:
        - The user can press Enter to load the next page.
        - The user can type 'q' to quit the process and exit the function."""

        while True:
            result_table = self.get_data_by_pages() # Calls the get_data_by_pages method to get a list of dictionaries (each row is a dictionary).
            if not result_table:
                print("\nNo more results found.")
                break
            # Converts data from a list of dictionaries (result_table) to a list of lists (table_data) so that it can be passed to the tabulate function.
            table_data = [[str(cell) if cell is not None else '' for cell in row.values()] for row in result_table]

            # Extracts the column names from the first row of data in the result_table and stores them as a list
            headers = list(result_table[0].keys())

            # Print the table with tabulate
            print(f"\nPage {self.page}:\n{'*' * 70}")
            print(tabulate(table_data, headers=headers, tablefmt="fancy_grid",
                           maxcolwidths=[10, 30, 40, 40, 40, 40, 40, 40, 40, 40]))
            print("*" * 40)

            # Offer the user to view the next page or exit the cycle
            while True:
                user_input = input("Press Enter to view next page or type 'q' to quit: ").lower()
                if user_input == 'q':
                    return # Ends execution of the function in which it was called if 'q' is entered
                if user_input == '':
                    self.page += 1 #Go to the next page
                    break # Exit the inner loop to continue pagination
                else:
                    print("Invalid input. Please press Enter or type 'q'.")

