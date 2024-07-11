Feature: Minesweeper

  Mauro López

  As a player:
  - I want to play to the classic minesweeper game
  - So I want to detect all the mines in the board

  How to refer to a cell: 
  - Using the (row,column) nomenclature
  - Rows and columns starts from 1

  How to load mock data: 
  - Using the <ctrl>+m keyboard combination to discover
    the load mock data form

  To define the board data will use: 
    "o" No mine
    "*" Mine
    "-" Row separator

    Thera are two ways to define mock data:
    - Inline:
      "*-ooo-*oo"
    - Table:
      | * | * | * |
      | o | o | o |
      | * | o | o |

  To define the board display will use:
    COVERED CELLS
      "." Hidden cell
      "!" Cell tagged has mined cell by the user
      "?" Cell tagged has inconclusive cell by the user
      "x" Cell wrongly tagged has no mined cell by the user
    UNCOVERED CELLS
      "0" Empty cell
      "1" Clean cell with 1 adjacent mine
      "2" Clean cell with 2 adjacent mines
      "3" Clean cell with 3 adjacent mines
      "4" Clean cell with 4 adjacent mines
      "5" Clean cell with 5 adjacent mines
      "6" Clean cell with 6 adjacent mines
      "7" Clean cell with 7 adjacent mines
      "8" Clean cell with 8 adjacent mines
      "@" highlighted mine
      "#" incorrect flag  
      "B" detonated mine 

Background:
    Given a user opens the app

@startingGame 
Scenario: Starting game - All the cells should be hidden
    Then all the cells should be covered     

Scenario: Starting game - All the cells should be enable 
    Then all the cells should be enable      

Scenario: Starting game - change game state in progress 
    Then the game state change to "in progress"

Scenario: Starting game - Unstarted timer 
    Then timer has the following value: "000"

@clickCells
Scenario: left-click on a cell without uncovering - Uncovering
    Given the player loads the following mock data:
    """
    | o | * |
    | * | * |
    """
    When the player left-click in (1,1)
    Then Uncovering a cell (1,1)

Scenario: left-click on a cell without uncovering - disable a cell
    Given the player loads the following mock data:
    """
    | o | * |
    | * | * |
    """
    When the player left-click in (1,1)
    Then disable a cell (1,1)

Scenario Outline: left-click on a cell with the mouse button uncovered
    Given the player loads the following mock data:
    """
    | 0 | 1 | o |
    | 1 | 2 | * |
    | * | o | o |
    """
    When the player left-click in (1,1)
    Then the minefield should look like this:

    Examples:
        """
        | 0 | 1 | o |
        | 1 | 2 | * |
        | * | o | o |
        """

Scenario Outline: right-click on a cell without uncovering - set flag
    Given the player loads the following mock data:
    """
    | o | * |
    | * | * |
    """
    When the player right-click in (1,1)
    Then the minefield should look like this:

    Examples:
        """
        | ! | * |
        | * | * |
        """

Scenario Outline: right-click on a cell without uncovering - inconclusive set
    Given the player loads the following mock data:
    """
    | ! | * |
    | * | * |
    """
    When the player right-click in (1,1)
    Then the minefield should look like this:

    Examples:
        """
        | ? | * |
        | * | * |
        """

Scenario Outline: right-click on a cell without uncovering - remove unfinished set
    Given the player loads the following mock data:
    """
    | ? | * |
    | * | * |
    """
    When the player right-click in (1,1)
    Then the minefield should look like this:

    Examples:
        """
        | o | * |
        | * | * |
        """

Scenario Outline: Uncovering a cell with no mine - Displaying the number of adjacent mines
    Given the player loads the following mock data: <boardData>
    When the player uncovers the cell (2,2)
    Then the cell (2,2) should show: <number>

    Examples:
        | boardData   | number | 
        | o*o-ooo-ooo |      1 | 
        | o*o-ooo-o*o |      2 |
        | o*o-*oo-o*o |      3 |
        | **o-*oo-o*o |      4 |
        | ***-*oo-o*o |      5 |
        | ***-*oo-**o |      6 |
        | ***-*oo-*** |      7 |
        | ***-*o*-*** |      8 |

Scenario Outline: Uncovering a cell with no mine or mines around it - Displaying an empty cell
    Given the player loads the following mock data:

    """
    | o | o | o | * |
    | o | o | o | * |
    | o | o | o | * |
    | * | * | * | * |
    """
    When the player uncovers the cell (<row>,<column>)
    Then the cell (2,2) should show: empty

    Examples:
        | row | column |
        | 1   | 1      |
        | 1   | 3      |    
        | 2   | 3      |
        | 3   | 2      |
        | 3   | 3      |
        | 3   | 2      |

@uncoveringMine
Scenario: Uncovering a cell with a mine - disable all cells
    Given the player loads the following mock data:

    """
    | * | o |
    | o | o |
    """
    When the player uncovers the cell (1,1)
    Then all cells should be disabled 

Scenario: Uncovering a cell with a mine - change game state to game over
    Given the player loads the following mock data:

    """
    | * | o |
    | o | o |
    """
    When the player uncovers the cell (1,1)
    Then the game state change to "game over"
  
Scenario Outline: Uncovering a cell with a mine - show unmarked mines 
    Given the player loads the following mock data:
    """
    | * | o | o | o |
    | o | o | o | o |
    | o | * | o | * |
    | * | o | * | o |
    """
    When the player uncovers the cell (1,1)
    Then the minefield should look like this:
    
    Examples: 
        """
        | B | o | o | o |
        | o | o | o | o |
        | o | @ | o | @ |
        | @ | o | @ | o |
        """

Scenario Outline: Uncovering a cell with a mine - show correct mines and flags
    Given the player loads the following mock data:
    """
    | * | o | o | o |
    | o | o | o | o |
    | o | ! | o | ! |
    | * | o | * | o |
    """
    When the player uncovers the cell (1,1)
    Then the minefield should look like this:
    
    Examples: 
        """
        | B | o | o | o |
        | o | o | o | o |
        | o | ! | o | ! |
        | @ | o | @ | o |
        """

Scenario Outline: Uncovering a cell with a mine - show mines and failed flags
    Given the player loads the following mock data:
    """
    | * | o | o | o |
    | o | o | x | o |
    | o | * | o | ! |
    | * | o | * | o |
    """
    When the player uncovers the cell (1,1)
    Then the minefield should look like this:
    
    Examples: 
        """
        | B | o | o | o |
        | o | o | # | o |
        | o | @ | o | ! |
        | @ | o | @ | o |
        """

Scenario Outline: Uncovering a cell with a mine - show mines and tagged inconclusive
    Given the player loads the following mock data:
    """
    | * | o | o | o |
    | o | ? | o | o |
    | o | * | o | ? |
    | * | o | * | o |
    """
    When the player uncovers the cell (1,1)
    Then the minefield should look like this:
    
    Examples: 
        """
        | B | o | o | o |
        | o | ? | o | o |
        | o | @ | o | ? |
        | @ | o | @ | o |
        """

@timer 
Scenario: Start timer - By clicking the first cell
    When the player clicking the first cell
    Then the timer state change to "start timer"

Scenario: Stop timer - By uncovering a cell with a mine
    Given the player loads the following mock data:

    """
    | * | o |
    | o | o |
    """
    When the player uncovers the cell (1,1)
    Then the timer state change to "stop timer"

Scenario Outline: Increase value of timer 
    When the timer value is: "<timerValue>"
    Then the display timer shows the following value: "<displayTimer>"

    Examples:
        | timerValue | displayTimer |
        |          1 |         001  |
        |          5 |         005  |
        |         10 |         010  |
        |         15 |         015  |
        |        100 |         100  |
        |        150 |         150  |

Scenario: Stop timer - The timer limit
    When the timer limit is reached   
    Then the timer state change to "stop timer"

Scenario: Stop timer - Game over
    When the game state is "game over"   
    Then the timer state change to "stop timer"

Scenario: Stop timer - you win 
    When the game state is "you win"   
    Then the timer state change to "stop timer"

@mineDisplay
Scenario Outline: Decreases the mine display - flag placed 
    Given the player loads the following mock data:
    And the mine display has the value "005"
    """
    | * | o | o | o |
    | o | * | o | o |
    | o | o | o | * |
    | * | o | * | o |
    """
    When player place a flag in the cell "<referCell>"
    Then the mine display has the value "<mineDisplay>"

    Examples:
        | referCell | mineDisplay | 
        |     (1,1) |         004 | 
        |     (1,2) |         003 | 
        |     (1,3) |         002 | 
        |     (1,4) |         001 |
        |     (2,1) |         000 |
        |     (2,2) |         -01 |
        |     (2,3) |         -02 |
        |     (2,4) |         -03 |

Scenario Outline: Increases mine display - right-click on a flag
    Given the player loads the following mock data:
    And the mine display has the value "-01"
    """
    | ! | x | x | x |
    | x | ! | o | o |
    | o | o | o | * |
    | * | o | * | o |
    """
    When player removes a flag in the cell "<referCell>"
    Then the mine display has the value "<mineDisplay>"

    Examples:
        | referCell | mineDisplay |
        |     (1,1) |         000 |
        |     (1,2) |         001 |
        |     (1,3) |         002 |
        |     (1,4) |         003 |
        |     (2,1) |         004 |

Scenario: max mine display 
    When the mine display limit is reached 
    Then the right button does not set flags 

@youWin
Scenario Outline: you win - all unmined cells are uncovered
    Given the player loads the following mock data:
        """
        | * | o | * |
        | * | * | o | 
        | o | * | * |
        """  
    When the player left-click in the cell (1,2)
    And the player left-click in the cell (2,3)
    And the player left-click in the cell (3,1)
    Then the minefield should look like this:

    Examples:
        """
        | ! | 4 | ! |
        | ! | ! | 4 |
        | 3 | ! | ! |
        """  

Scenario: you win - change game state to you win
    Given the player loads the following mock data:
        """
        | o | * |
        | * | * |
        """  
    When the player left-click in the cell (1,1)
    Then the game state change to "you win"

Scenario: you win - disable all cells
    Given the player loads the following mock data:
        """
        | o | * |
        | * | * |
        """  
    When the player left-click in the cell (1,1)
    Then all cells should be disabled   

@buttonNewGame
Scenario Outline: click new game button - you win
    Given the player loads the following mock data:
        """
        | ! | 4 | ! |
        | ! | ! | 4 |
        | 3 | ! | ! |
        """  
    When the player click new game button 
    Then the minefield should look like this:

    Examples:
        """
        | . | . | . |
        | . | . | . |
        | . | . | . |
        """  

Scenario: click new game button - change game state to in progress 
    When the player click new game button 
    Then the game state change to "in progress"

Scenario: click new game button - enable all cells
    Given the player loads the following mock data:
        """
        | ! | 4 | ! |
        | ! | ! | 4 |
        | 3 | ! | ! |
        """  
    When the player click new game button 
    Then all cells should be enable 

@otherTests
Scenario Outline: hold down the left button on a cell - view mine area
    Given the player loads the following mock data:
        """
        | 1 | 1 | . |
        | 2 | . | . |
        | . | . | 1 |
        """
    When the player hold down the left button whit a cell
    Then the minefield should look like this:

    Examples:
        """
        | 1 | 1 | 0 |
        | 2 | 0 | 0 |
        | . | . | 1 |
        """

Scenario Outline: stops holding down the left button on a cell - view mine area
    Given the player loads the following mock data:
        """
        | 1 | 1 | . |
        | 2 | . | . |
        | . | . | 1 |
        """
    When the player hold down the left button whit a cell
    And the player stops holding down the left mouse button with a cell
    Then the minefield should look like this:

    Examples:
        """
        | 1 | 1 | . |
        | 2 | . | . |
        | . | . | 1 |
        """
