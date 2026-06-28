use std::{
    fs::File,
    sync::{
        mpsc::{self, Sender},
        Mutex,
    },
    time::Duration,
};

use lazy_static::lazy_static;
use rodio::{Decoder, DeviceSinkBuilder, Player};

enum Cmd {
    PlayFile(String),
    Play,
    Pause,
    Seek(u64),
}

pub fn play_file(path: String) -> Result<(), String> {
    if let Some(tx) = CMD_TX.lock().unwrap().as_ref() {
        tx.send(Cmd::PlayFile(path)).map_err(|e| e.to_string())?;
    }
    Ok(())
}

pub fn play() {
    if let Some(tx) = CMD_TX.lock().unwrap().as_ref() {
        let _ = tx.send(Cmd::Play);
    }
}

pub fn pause() {
    if let Some(tx) = CMD_TX.lock().unwrap().as_ref() {
        let _ = tx.send(Cmd::Pause);
    }
}

pub fn seek(secs: u64) {
    if let Some(tx) = CMD_TX.lock().unwrap().as_ref() {
        let _ = tx.send(Cmd::Seek(secs));
    }
}

lazy_static! {
    static ref CMD_TX: Mutex<Option<Sender<Cmd>>> = Mutex::new(None);
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    let (tx, rx) = mpsc::channel::<Cmd>();
    *CMD_TX.lock().unwrap() = Some(tx);
    std::thread::spawn(move || {
        let _sink = DeviceSinkBuilder::open_default_sink().unwrap();
        let player = Player::connect_new(_sink.mixer());
        for cmd in rx {
            match cmd {
                Cmd::PlayFile(s) => {
                    _play_file(&player, &s);
                }
                Cmd::Pause => {
                    _pause(&player);
                }
                Cmd::Seek(n) => {
                    _seek(&player, n);
                }
                Cmd::Play => {
                    _play(&player);
                }
            }
        }
    });
}

fn _play_file(player: &Player, path: &str) {
    let file = File::open(path).expect("Error0");
    let source = Decoder::try_from(file).expect("Error1");
    player.append(source);
}

fn _pause(player: &Player) {
    player.pause();
}

fn _play(player: &Player) {
    player.play();
}

fn _seek(player: &Player, num: u64) {
    let dr = Duration::from_secs(num);
    player.try_seek(dr).expect("Error_seek");
}
