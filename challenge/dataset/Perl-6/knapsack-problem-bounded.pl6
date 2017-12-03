my class KnapsackItem { has $.name; has $.weight; has $.unit; }

multi sub pokem ([],           $,  $v = 0) { $v }
multi sub pokem ([$,  *@],     0,  $v = 0) { $v }
multi sub pokem ([$i, *@rest], $w, $v = 0) {
  my $key = "{+@rest} $w $v";
  (state %cache){$key} or do {
    my @skip = pokem @rest, $w, $v;
    if $w >= $i.weight { # next one fits
      my @put = pokem @rest, $w - $i.weight, $v + $i.unit;
      return (%cache{$key} = |@put, $i.name).list if @put[0] > @skip[0];
    }
    return (%cache{$key} = |@skip).list;
  }
}

my $MAX_WEIGHT = 400;
my @table = flat map -> $name,  $weight,  $unit,     $count {
     KnapsackItem.new( :$name, :$weight, :$unit ) xx $count;
},
        'map',                         9,      150,    1,
        'compass',                     13,     35,     1,
        'water',                       153,    200,    2,
        'sandwich',                    50,     60,     2,
        'glucose',                     15,     60,     2,
        'tin',                         68,     45,     3,
        'banana',                      27,     60,     3,
        'apple',                       39,     40,     3,
        'cheese',                      23,     30,     1,
        'beer',                        52,     10,     3,
        'suntan cream',                11,     70,     1,
        'camera',                      32,     30,     1,
        'T-shirt',                     24,     15,     2,
        'trousers',                    48,     10,     2,
        'umbrella',                    73,     40,     1,
        'waterproof trousers',         42,     70,     1,
        'waterproof overclothes',      43,     75,     1,
        'note-case',                   22,     80,     1,
        'sunglasses',                  7,      20,     1,
        'towel',                       18,     12,     2,
        'socks',                       4,      50,     1,
        'book',                        30,     10,     2
        ;

my ($value, @result) = pokem @table, $MAX_WEIGHT;

(my %hash){$_}++ for @result;

say "Value = $value";
say "Tourist put in the bag:";
say "  # ITEM";
for %hash.sort -> $item {
  say "  {$item.value} {$item.key}";
}
