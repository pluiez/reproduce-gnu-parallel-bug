## Reproduce GNU Parallel bug

Simply run `bash run_tests.sh test.input 1000`, where `1000` is the number of tests to run.

The script runs 1000 tests, each use `parallel -a $input -j64 -k --pipepart --block -1 "cat"` to cat the input file and check if the output has the same sha256sum as the input file.

It's observed that occasionally the input file and the output file have different sha256sum. By checking the input and output file line by line, the output file starts differing from the middle of a line, indicating a corrupted record caused by unknwon reason.

Tested environment: 
* GNU parallel 20241122
* Ubuntu 20.04
* Perl -v
  * `This is perl 5, version 30, subversion 0 (v5.30.0) built for x86_64-linux-gnu-thread-multi`
  * `This is perl 5, version 40, subversion 0 (v5.40.0) built for x86_64-linux`
* /usr/bin/zsh and /usr/bin/bash
* locale:
```
LANG=en_US.UTF-8
LANGUAGE=
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=
```

Script output:

```text
❯  bash run_tests.sh test.input 100
[Hash mismatch @ 33] input: hash=07ba1a97df530918ee4bf14891a7e5ed5b654c47a2239a0beea2d83e495dc6cc, path=test.input; output: hash=d61345d7b6a1275c73f650d2ebd00878d53933697419f469188aa804763657e5, path=test.input.test-parallel-cat.33
[Hash mismatch @ 34] input: hash=07ba1a97df530918ee4bf14891a7e5ed5b654c47a2239a0beea2d83e495dc6cc, path=test.input; output: hash=3f75daa714644353a18611cea0441c326606f36fa76fdf280625fe5c5762b5d4, path=test.input.test-parallel-cat.34
[Hash mismatch @ 35] input: hash=07ba1a97df530918ee4bf14891a7e5ed5b654c47a2239a0beea2d83e495dc6cc, path=test.input; output: hash=7b6c3336d595f4c95aff733e805273281b23c17feb7f09bf03f26aef4bb24974, path=test.input.test-parallel-cat.35
[Hash mismatch @ 36] input: hash=07ba1a97df530918ee4bf14891a7e5ed5b654c47a2239a0beea2d83e495dc6cc, path=test.input; output: hash=01cf822f93eed32ec692276a94428f746a524755bbbc0cbfd93f67952818b51b, path=test.input.test-parallel-cat.36
[Hash mismatch @ 37] input: hash=07ba1a97df530918ee4bf14891a7e5ed5b654c47a2239a0beea2d83e495dc6cc, path=test.input; output: hash=a54813dae21004092ddbb144312063785fe04cedf4fd6b2b8edc084e4e70f9fc, path=test.input.test-parallel-cat.37
[Hash mismatch @ 38] input: hash=07ba1a97df530918ee4bf14891a7e5ed5b654c47a2239a0beea2d83e495dc6cc, path=test.input; output: hash=80680f3dd07dc5dc7783f79c14ba7a502809f019b5fe311d085084da254fcdb4, path=test.input.test-parallel-cat.38
[Hash mismatch @ 39] input: hash=07ba1a97df530918ee4bf14891a7e5ed5b654c47a2239a0beea2d83e495dc6cc, path=test.input; output: hash=a461fc8e596b11db85a4746e433fe641d981b859f400d62945de4b3c819cb90a, path=test.input.test-parallel-cat.39
[Hash mismatch @ 40] input: hash=07ba1a97df530918ee4bf14891a7e5ed5b654c47a2239a0beea2d83e495dc6cc, path=test.input; output: hash=c41a01a983f56e712104eb46d9f3b65bab4e7c9444f17c4955db39b58c906175, path=test.input.test-parallel-cat.40
[Hash mismatch @ 41] input: hash=07ba1a97df530918ee4bf14891a7e5ed5b654c47a2239a0beea2d83e495dc6cc, path=test.input; output: hash=c41a01a983f56e712104eb46d9f3b65bab4e7c9444f17c4955db39b58c906175, path=test.input.test-parallel-cat.41
[Hash mismatch @ 42] input: hash=07ba1a97df530918ee4bf14891a7e5ed5b654c47a2239a0beea2d83e495dc6cc, path=test.input; output: hash=783c091391af5621a23e17134434b73ac0a7d4417c6a02251f75ef90e2a1971e, path=test.input.test-parallel-cat.42
[Hash mismatch @ 43] input: hash=07ba1a97df530918ee4bf14891a7e5ed5b654c47a2239a0beea2d83e495dc6cc, path=test.input; output: hash=b9b54e10607f4f20b78c92a006a14b521933d92c34eec50a64d9f932fe9181d5, path=test.input.test-parallel-cat.43
[Hash mismatch @ 44] input: hash=07ba1a97df530918ee4bf14891a7e5ed5b654c47a2239a0beea2d83e495dc6cc, path=test.input; output: hash=b9b54e10607f4f20b78c92a006a14b521933d92c34eec50a64d9f932fe9181d5, path=test.input.test-parallel-cat.44
[Hash mismatch @ 45] input: hash=07ba1a97df530918ee4bf14891a7e5ed5b654c47a2239a0beea2d83e495dc6cc, path=test.input; output: hash=621adeb2ecde185adbac4e6eaccdc3bf9c225ad56d00125c84856692ee084d38, path=test.input.test-parallel-cat.45
[Hash mismatch @ 46] input: hash=07ba1a97df530918ee4bf14891a7e5ed5b654c47a2239a0beea2d83e495dc6cc, path=test.input; output: hash=68832d6814fc5eeca01708b1eca3ad165548e9bd5d5fdbc4d1c9db290676f24a, path=test.input.test-parallel-cat.46
[Hash mismatch @ 47] input: hash=07ba1a97df530918ee4bf14891a7e5ed5b654c47a2239a0beea2d83e495dc6cc, path=test.input; output: hash=68832d6814fc5eeca01708b1eca3ad165548e9bd5d5fdbc4d1c9db290676f24a, path=test.input.test-parallel-cat.47
```

Running the script multiple times leads to different results. The mismatches happen at at different tests for different runs.
