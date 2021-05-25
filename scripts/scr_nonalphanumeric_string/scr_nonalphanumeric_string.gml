/// @desc Returns all non-alphanumeric characters.
//        Inclusions and exclusions may be added as arrays of individual chars which will then either be included or excluded from the returned string.
//        Desired alphanumeric chars may be included while undesired non-alphanumeric characters may be excluded.
/// @param {string} str The input string
/// @param {array} [inclusions] An array of individual alphanumeric characters to include in the returned string
/// @param {array} [exclusions] An array of individual non-alphanumeric characters to exclude from the returned string

function scr_nonalphanumeric_string(){

	//get input string
	var inputStr = argument[0];
	//get output string
	var outputStr = "";

	//get array of inclusions
	var inclusions = ds_list_create();
	//get array of exclusions
	var exclusions = ds_list_create();

	//An error message about arrays
	var arr_error_message = "To enter an array without first establishing it as a variable in Game Maker: Studio 2,\r\nsimply open with \"[\", type single chars \"c\" with \",\" (comma separators), and close with \"]\".\r\nExample: [\"c\",\"h\",\"a\",\"r\",\"1\",\"2\",\"3\"]\r\nSee: https://docs.yoyogames.com/source/dadiospice/002_reference/001_gml%20language%20overview/401_06_arrays.html for more info.\r\nAborting game.";

	#region check inclusions if argument[1] used
	if (argument_count > 1)
	{
	    var arr = argument[1];
	    //acquire
	    if (is_array(arr))
	    {
	        //Get chars, throw error if any index in argument 1 contains string with length greater than 1.
	        for (var i = 0; i < array_length_1d(arr); ++i)
	        {
	            //Check that each char is a string and only one char long
	            if (string_length(arr[i]) < 2 && is_string(arr[i]))
	            {
	                //set value in ds_list
	                inclusions[| i] = arr[i];
	            }
	            else
	            {
	                //not a string!
	                if !is_string(arr[i])
	                {
	                    ds_list_destroy(inclusions);
	                    ds_list_destroy(exclusions);
	                    show_error("Character exception: Input \""+string(arr[i])+"\" in string_notalphanumeric (argument[inclusions]) is not a string! Aborting game.",true);
	                    return -1;
	                }
	                //index contains more than one character!
	                else
	                {
	                    ds_list_destroy(inclusions);
	                    ds_list_destroy(exclusions);
	                    show_error("Character exception: Input \""+string(arr[i])+"\" in string_notalphanumeric (argument[inclusions]) must contain only a single-character\r\nin each array index!\r\n"+arr_error_message,true);
	                    return -1;
	                }
	            }
	        }
	    }
	    //error if not an array!
	    else
	    {
	        ds_list_destroy(inclusions);
	        ds_list_destroy(exclusions);
	        show_error("Character exception: Input \""+string(arr)+"\" in string_notalphanumeric (argument[inclusions]) must be an array!\r\n(Also, must not be a ds_list!))\r\n"+arr_error_message,true);
	        return -1;
	    }
	}
	#endregion
	#region check exclusions if argument[2] used
	if (argument_count > 2)
	{
	    var arr = argument[2];
	    //acquire
	    if (is_array(arr))
	    {
	        //Get chars, throw error if any index in argument 1 contains string with length greater than 1.
	        for (var i = 0; i < array_length_1d(arr); ++i)
	        {
	            //Check that each char is a string and only one char long
	            if (string_length(arr[i]) < 2 && is_string(arr[i]))
	            {
	                //set value in ds_list
	                exclusions[| i] = arr[i];
	            }
	            else
	            {
	                //not a string!
	                if !is_string(arr[i])
	                {
	                    ds_list_destroy(inclusions);
	                    ds_list_destroy(exclusions);
	                    show_error("Character exception: Input \""+string(arr[i])+"\" in string_notalphanumeric (argument[exclusions]) is not a string! Aborting game.",true);
	                    return -1;
	                }
	                //index contains more than one character!
	                else
	                {
	                    ds_list_destroy(inclusions);
	                    ds_list_destroy(exclusions);
	                    show_error("Character exception: Input \""+string(arr[i])+"\" in string_notalphanumeric (argument[exclusions]) must contain only a single-character\r\nin each array index!\r\n"+arr_error_message,true);
	                    return -1;
	                }
	            }
	        }
	    }
	    //error if not an array!
	    else
	    {
	        ds_list_destroy(inclusions);
	        ds_list_destroy(exclusions);
	        show_error("Character exception: Input \""+string(arr)+"\" in string_notalphanumeric (argument[exclusions]) must be an array!\r\n(Also, must not be a ds_list!))\r\n"+arr_error_message,true);
	        return -1;
	    }
	}
	#endregion

	//check if input was a string
	if is_string(inputStr)
	{  
	    //iterate input string
	    for (var i = 1; i <= string_length(inputStr); ++i)
	    {
	        //acquire chars based on args
	        if (string_lettersdigits(string_char_at(inputStr,i)) == "" && is_undefined(exclusions[| ds_list_find_index(exclusions,string_char_at(inputStr,i))])
	            || string_lettersdigits(string_char_at(inputStr,i)) != "" && !is_undefined(inclusions[| ds_list_find_index(inclusions,string_char_at(inputStr,i))]))
	        {
	            //concatonate to output string
	            outputStr += string_char_at(inputStr,i);
	        }
	    }
   
	    //return resultant string
	    ds_list_destroy(inclusions);
	    ds_list_destroy(exclusions);
	    return outputStr;
	}
	//else
	//throw error and end game
	else
	{
	    ds_list_destroy(inclusions);
	    ds_list_destroy(exclusions);
	    show_error("Input: \""+string(inputStr)+"\" in string_notalphanumeric (argument[str]) is not a string! Aborting game.",true);
	    return -1;
	}

}