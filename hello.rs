use std::{fmt::Debug, io, str::FromStr};

//============================================
// Solution
//============================================

pub fn main() {
    println!("Hello, world!");
}

//============================================
// StdIn Helpers
//============================================

#[allow(unused)]
#[inline(always)]
fn next<T: FromStr>(buffer: &mut String) -> T
where
    <T as FromStr>::Err: Debug,
{
    io::stdin().read_line(buffer).unwrap();
    buffer.trim().parse::<T>().unwrap()
}

#[allow(unused)]
#[inline(always)]
fn next_tuple<T: FromStr>(buffer: &mut String) -> (T, T)
where
    <T as FromStr>::Err: Debug,
{
    io::stdin().read_line(buffer).unwrap();
    let mut iter = buffer.trim().split(' ').map(|s| s.parse::<T>().unwrap());
    (iter.next().unwrap(), iter.next().unwrap())
}

#[allow(unused)]
#[inline(always)]
fn next_vec<T: FromStr>(buffer: &mut String) -> Vec<T>
where
    <T as FromStr>::Err: Debug,
{
    io::stdin().read_line(buffer).unwrap();
    buffer
        .trim()
        .split(' ')
        .map(|s| s.parse::<T>().unwrap())
        .collect::<Vec<T>>()
}

