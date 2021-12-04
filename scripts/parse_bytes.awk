{
	rate=1024;

	b = $1;
	k = b/rate;
	m = k/rate;
	g = m/rate;
	t = g/rate;
}

END {
	if(b < rate)
		printf("%fB", b)
	else if(k < rate)
		printf("%fKB", k)
	else if(m < rate)
		printf("%fMB", m)
	else if(g < rate)
		printf("%fGB", g)
	else
		printf("%fTB ", t)
}
