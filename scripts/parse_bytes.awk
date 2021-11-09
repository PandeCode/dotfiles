{
	rate=1024;

	b = $1;
	k = b/rate;
	m = k/rate;
	g = m/rate;
	t = g/rate;
}

END {
	printf("%fB | %fKB | %fMB | %fGB | %fTB ",
		   b, k, m, g, t)
}
