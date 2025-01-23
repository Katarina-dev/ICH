import unittest
import user_input
from unittest.mock import patch
import io


class MyTestCase(unittest.TestCase):

    @patch('builtins.input', side_effect=['A' * 101, 'Title123', 'Valid Title']) #mock input from the user
    @patch('sys.stdout', new_callable=io.StringIO) #io.StringIO - file object that will store the output of the print function
    # mock_stdout - object that will store the output of the print function
    # mock_input - object that will store the input from the user
    def test_title_exceptions(self, mock_stdout, mock_input):
        result = user_input.get_user_title()
        # check if the output contains the expected message
        self.assertIn('Invalid title. Title must be less than 100 characters',mock_stdout.getvalue())  # getvalue() - get the value of the stored "output"
        self.assertIn('Invalid title. The title must not contain numbers.', mock_stdout.getvalue())
        self.assertEqual(result, 'Valid Title')


    @patch('builtins.input', side_effect=['A' * 33,'Genre123', 'Valid Genre'])
    @patch('sys.stdout', new_callable=io.StringIO)
    def test_genre_exceptions(self, mock_stdout, mock_input):
        result = user_input.get_user_genre()
        self.assertIn('Invalid name of genre. Name of genre must be less than 32 characters', mock_stdout.getvalue())
        self.assertIn('Invalid name of genre. The genre name must not contain numbers.', mock_stdout.getvalue())
        self.assertEqual(result, 'Valid Genre')


    @patch('builtins.input', side_effect=['jk', '1900', '2156', '2006'])
    def test_year_exceptions(self, mock_input):
        """Test invalid year (out of range) with appropriate message."""
        with patch('builtins.print') as mock_print:
            result = user_input.get_user_year()  # The first attempt (1800) called an error
            mock_print.assert_any_call('Invalid input. Please enter a numeric year.') #method assert_any_call - check if the method was called with the specified arguments
            mock_print.assert_any_call('Invalid year. Year must be between 1901 and 2155.')
            mock_print.assert_any_call('Invalid year. Year must be between 1901 and 2155.')
            self.assertEqual(result, 2006)  # The second attempt (2006) returns the correct value


    @patch('builtins.input', side_effect=['Ben123', 'A' * 51, 'Valid Actor'])
    @patch('sys.stdout', new_callable=io.StringIO)
    def test_genre_exceptions(self, mock_stdout, mock_input):
        result = user_input.get_user_actor()
        self.assertIn('Invalid actor last name. The actor last name must not contain numbers.', mock_stdout.getvalue())
        self.assertIn('Invalid actor last name. Actor last name must be less than 50 characters',mock_stdout.getvalue())
        self.assertEqual(result, 'Valid Actor')


if __name__ == '__main__':
    unittest.main()