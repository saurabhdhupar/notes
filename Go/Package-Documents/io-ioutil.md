## Overview
实现了一些 I/O 通用函数

## Variables
```go
var Discard io.Writer = devNull(0)
```
Discard is an io.Writer on which all Write calls succeed without doing anything

## Functions
```go
func NopCloser(r io.Reader) io.ReadCloser
/**
 * 将 io.Reader 包装为 io.ReadCloser
**/

```
```go
func ReadAll(r io.Reader) ([]byte, error)
/**
**/

```
```go
func ReadDir(dirname string) ([]os.FileInfo, error)
/**
**/

```
```go
func ReadFile(filename string) ([]byte, error)
/**
**/

```
```go
func TempDir(dir, prefix string) (name string, err error)
/**
**/

```
```go
func TempFile(dir, prefix string) (f *os.File, err error)
/**
**/

```
```go
func WriteFile(filename string, data []byte, perm os.FileMode) error
/**
**/

```
