export CUDA_VISIBLE_DEVICES=3
DATA_PATH=/data1/DATASET/MSRVTT
python -m torch.distributed.launch --nproc_per_node=1 --master_port 23903 \
main_task_retrieval.py --do_train --num_thread_reader=12 \
--epochs=5 --batch_size=128 --n_display=50 \
--train_csv ${DATA_PATH}/msrvtt_data/MSRVTT_train.9k.csv \
--val_csv ${DATA_PATH}/msrvtt_data/MSRVTT_JSFUSION_test.csv \
--data_path ${DATA_PATH}/msrvtt_data/MSRVTT_data.json \
--features_path ${DATA_PATH}/compress_videos \
--output_dir ckpts/ckpt_pretrain_msrvtt_2M_1e-4_random1_logsoftmax_b32 \
--lr 1e-4 --max_words 32 --max_frames 12 --batch_size_val 32 \
--datatype msrvtt --expand_msrvtt_sentences  \
--feature_framerate 1 --coef_lr 1e-3 \
--freeze_layer_num 0  --slice_framepos 2 \
--loose_type --linear_patch 2d --sim_header seqTransf \
--init_model ckpts/ckpt_pretrain_logsoftmax_tempsimsiam_0.1_2M_1e-4_b32/pytorch_model.bin.2 \
--pretrained_clip_name ViT-B/32