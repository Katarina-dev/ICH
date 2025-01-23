import unittest
import user_input
from unittest.mock import patch
import io


class MyTestCase(unittest.TestCase):

    @patch('builtins.input', side_effect=['Title123', 'Valid Title']) #mock input from the user
    @patch('sys.stdout', new_callable=io.StringIO) #io.StringIO - file object that will store the output of the print function
    # mock_stdout - object that will store the output of the print function
    # mock_input - object that will store the input from the user
    def test_title_with_numbers(self, mock_stdout, mock_input):
        result = user_input.get_user_title()
        # check if the output contains the expected message
        self.assertIn('Invalid title. The title must not contain numbers.', mock_stdout.getvalue())
        self.assertEqual(result, 'Valid Title')

    @patch('builtins.input', side_effect=['A' * 101, 'Valid Title']) #side_effect - list of values that will be returned by the mock
    @patch('sys.stdout', new_callable=io.StringIO) #new_callable - the type of object that will store the output of the print function
    def test_title_too_long(self, mock_stdout, mock_input):
        result = user_input.get_user_title()
        self.assertIn('Invalid title. Title must be less than 100 characters', mock_stdout.getvalue()) #getvalue() - get the value of the stored "output"
        self.assertEqual(result, 'Valid Title')

    # @patch('builtins.input', return_value='Valid Title')
    # def test_valid_title(self, mock_input):
    #     result = user_input.get_user_title()
    #     self.assertEqual(result, 'Valid Title')

    @patch('builtins.input', side_effect=['Genre123', 'Valid Genre'])
    @patch('sys.stdout', new_callable=io.StringIO)
    def test_genre_with_numbers(self, mock_stdout, mock_input):
        result = user_input.get_user_genre()
        self.assertIn('Invalid name of genre. The genre name must not contain numbers.', mock_stdout.getvalue())
        self.assertEqual(result, 'ValidGenre')

    @patch('builtins.input', side_effect=['A' * 33, 'Valid Genre'])
    @patch('sys.stdout', new_callable=io.StringIO)
    def test_genre_too_long(self, mock_stdout, mock_input):
        result = user_input.get_user_genre()
        self.assertIn('Invalid name of genre. Name of genre must be less than 32 characters', mock_stdout.getvalue())
        self.assertEqual(result, 'ValidGenre')

    @patch('builtins.input', side_effect=['1800', '1901'])
    def test_year_out_of_range(self, mock_input):
        """Test invalid year (out of range) with appropriate message."""
        with patch('builtins.print') as mock_print:
            result = user_input.get_user_year()  # Первая попытка (1800) вызывает ошибку
            mock_print.assert_any_call('Invalid year. Year must be between 1901 and 2155')
            self.assertEqual(result, 1901)  # Вторая попытка (2006) возвращает корректное значение

    @patch('builtins.input', side_effect=['jk', '2006'])
    def test_year_out_of_range(self, mock_input):
        """Test invalid year (out of range) with appropriate message."""
        with patch('builtins.print') as mock_print:
            result = user_input.get_user_year()  # Первая попытка (jk) вызывает ошибку
            mock_print.assert_any_call('Invalid input. Please enter a numeric year.')
            self.assertEqual(result, 2006)  # Вторая попытка (2006) возвращает корректное значение

    @patch('builtins.input', side_effect=['Ben123', 'Valid Actor'])
    @patch('sys.stdout', new_callable=io.StringIO)
    def test_genre_with_numbers(self, mock_stdout, mock_input):
        result = user_input.get_user_actor()
        self.assertIn('Invalid actor last name. The actor last name must not contain numbers.', mock_stdout.getvalue())
        self.assertEqual(result, 'Valid Actor')

    @patch('builtins.input', side_effect=['A' * 51, 'Valid Actor'])
    @patch('sys.stdout', new_callable=io.StringIO)
    def test_genre_too_long(self, mock_stdout, mock_input):
        result = user_input.get_user_actor()
        self.assertIn('Invalid actor last name. Actor last name must be less than 50 characters', mock_stdout.getvalue())
        self.assertEqual(result, 'Valid Actor')






if __name__ == '__main__':
    unittest.main()