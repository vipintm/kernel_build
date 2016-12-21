use strict;
my @file=(<>);
my $temp=join " ",@file;
my @charArr=split //,$temp;
my $flag=0;
for(my $i=0;$i<=@charArr;$i++)
{
	if ($charArr[$i] eq "{")
	{
		$flag++;
		print "{<$flag>{";
	}
	elsif ($charArr[$i] eq "}")
        {
                print "}<$flag>}";
                $flag--;
        }
	else
	{
		print $charArr[$i];
	}	
	
}
