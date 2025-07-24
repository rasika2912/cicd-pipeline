from src.main import add ,subtract,multiply
def test_add_function():
    assert add(2,3)==5
    assert add(0,0)==0
    assert add(5,5)==10

def test_subtract_function():
    assert subtract(3,3)==0
    assert subtract(0,0)==0
    assert subtract(10,5)==5

def test_multiply_function():
    assert multiply(3, 3) == 0
    assert multiply(0, 0) == 0
    assert multiply(10, 5) == 5
