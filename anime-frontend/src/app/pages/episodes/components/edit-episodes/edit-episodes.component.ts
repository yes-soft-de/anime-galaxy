import { DatePipe, formatDate } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Observable } from 'rxjs';
import { map, mergeMap } from 'rxjs/operators';
import { HelperService } from 'src/app/@theme/helper/helper.service';
import { TokenService } from 'src/app/pages/admin-service/token/token.service';
import { AnimesResponse } from 'src/app/pages/animes/entity/animes-response';
import { AnimeService } from 'src/app/pages/animes/services/anime.service';
import { ImageSnippet } from 'src/app/pages/categories/entity/image-snippet';
import { ListCategoryResponse } from 'src/app/pages/categories/entity/list-category-response';
import { CategoryService } from 'src/app/pages/categories/services/category.service';
import { EditEpisode } from '../../entity/edit-episode';
import { EditEpisodeResponse } from '../../entity/edit-episode-response';
import { EpisodesService } from '../../services/episodes.service';
import { Options } from 'select2';

@Component({
  selector: 'app-edit-episodes',
  templateUrl: './edit-episodes.component.html',
  providers: [DatePipe]
})
export class EditEpisodesComponent implements OnInit {
  episodeID: number;
  mergeResult: {
    animes: AnimesResponse
    categories: ListCategoryResponse,
  }
  episodesData: EditEpisode;
  isSubmitted = false;
  uploadForm: FormGroup;
  uploadButtonValue = 'Upload';
  mainUploadButtonValue = 'Upload';
  imageName = 'Leave it if you don\'t want to change image';
  mainImageName = 'Leave it if you don\'t want to change main image';
  fileSelected = false;
  mainFileSelected = false;
  imageUrl: string;
  mainImageUrl: string;
  imagePathReady = true;
  mainImagePathReady = true;
  submitButtonValue = 'Update Episode';
  selectedFile: ImageSnippet;
  public selectData: Array<{ id: string; text: string; }> = [];
  public options: Options;
  public value: string[] = [];


  constructor(private episodeService: EpisodesService,
              private tokenService: TokenService,
              private animeService: AnimeService,
              private categoryService: CategoryService,
              private formBuilder: FormBuilder,
              private toaster: ToastrService,
              private datePipe: DatePipe,
              private router: Router,
              private activatedRoute: ActivatedRoute) {
  }



  ngOnInit() {

    this.episodeID = parseInt(this.activatedRoute.snapshot.paramMap.get('id'));
    this.episodeService.getEpisode(this.episodeID).subscribe(
     (episodeResponse: EditEpisodeResponse) => {
      //  console.log('episodeResponse', episodeResponse);
        this.episodesData = episodeResponse.Data;
        this.updateFormValues();
      }
    );


    const animes: Observable<AnimesResponse> = this.animeService.allAnimes();
    const categories: Observable<ListCategoryResponse> = this.categoryService.allCategories();
    const result: Observable<any> = animes.pipe(
      mergeMap(animesResponse => {
        return categories.pipe(
          map(categoriesResponse => {
            const result = {
              animes: animesResponse,
              categories: categoriesResponse
            };
            return result;
        }))
      })
    );
    result.subscribe(
      mergeResponse => {
        // console.log('episode', mergeResponse);
        this.mergeResult = mergeResponse;
        this.mergeResult.categories.Data.map(e => {
          // id : must be as string
          this.selectData.push({id: `${e.id}`, text: e.name});
        });
        this.episodesData.categories.map(e => {
          // id : must be as string
         this.value.push(`${e.id}`);
       });
      }
    );

    // Fetch Form Data
    this.uploadForm = this.formBuilder.group({
      animeID: ['', Validators.required],
      // categoyID: ['', Validators.required],
      categories: [''],
      seasonNumber: ['', [Validators.required, Validators.minLength(1)]],
      episodeNumber: ['', [Validators.required, Validators.minLength(1)]],
      description: ['', Validators.required],
      image: [''],
      posterImage: [''],
      duration: ['', Validators.required],
      publishDate: ['', Validators.required]
    });

    // Options For Select 2
    this.options = {
      width: '100%',
      placeholder: 'Type Episodes Categories',
      multiple: true,
      tags: true
    };
  }

  // Fill Form Input
  updateFormValues() {
    this.uploadForm.patchValue({    // Insert Our category Data Into Form Fields
      animeID: this.episodesData.animeID,       // we must use the id not the name to make relate with select html tag
      // categoyID: this.episodesData.categoryID,
      categories: this.episodesData.categories,  // we must use the id not the name to make relate with select html tag
      seasonNumber: this.episodesData.seasonNumber,
      episodeNumber: this.episodesData.episodeNumber,
      description: this.episodesData.description,
      image: this.episodesData.image,
      posterImage: this.episodesData.posterImage,
      duration: HelperService.convertSecondsToHMS(this.episodesData.duration.timestamp),
      publishDate: this.datePipe.transform(new Date(this.episodesData.publishDate?.timestamp * 1000), 'yyyy-MM-dd'),
    });
  }

  // Choose Anime Using Select Dropdown
  changeAnime(event) {
    this.uploadForm.get('animeID').setValue(event.target.value, {
      onlySelf: true
    });
  }

  // Choose Category Using Select Dropdown
  // changeCategory(event) {
  //   this.uploadForm.get('categoyID').setValue(event.target.value, {
  //     onlySelf : true
  //   });
  // }


  // Get Image Information
  updateName(imageInput: any) {
    const file: File = imageInput.files[0];
    this.uploadButtonValue = 'Upload';
    this.imageName = file.name;
    this.fileSelected = true;
  }


  updateMainName(imageInput: any) {
    const file: File = imageInput.files[0];
    this.mainUploadButtonValue = 'Upload';
    this.mainImageName = file.name;
    this.mainFileSelected = true;
  }

  // Upload Image
  processFile(imageInput: any) {
    this.fileSelected = false;
    this.uploadButtonValue = 'Uploading...';
    console.log('Processing File');
    const file: File = imageInput.files[0];
    const reader = new FileReader();

    reader.addEventListener('load', (event: any) => {
      this.selectedFile = new ImageSnippet(event.target.result, file);
      this.animeService.uploadImage(this.selectedFile.file).subscribe(
        (res) => {
          console.log(res);
          this.imageUrl = res;
          this.uploadButtonValue = 'Uploaded';
          this.imagePathReady = true;
          this.submitButtonValue = 'Update Episode';
        },
        (err) => {
          console.log(err);
        });
    });
    reader.readAsDataURL(file);
  }


  processMainFile(imageInput: any) {
    this.mainFileSelected = false;
    this.mainUploadButtonValue = 'Uploading...';
    console.log('Processing File');
    const file: File = imageInput.files[0];
    const reader = new FileReader();

    reader.addEventListener('load', (event: any) => {
      this.selectedFile = new ImageSnippet(event.target.result, file);
      this.animeService.uploadImage(this.selectedFile.file).subscribe(
        (res) => {
          console.log(res);
          this.mainImageUrl = res;
          this.mainUploadButtonValue = 'Uploaded';
          this.mainImagePathReady = true;
          this.submitButtonValue = 'Update Episode';
        },
        (err) => {
          console.log(err);
        });
    });
    reader.readAsDataURL(file);
  }


  mySubmit() {
    this.isSubmitted = true;
    if (!this.uploadForm.valid) {
      this.toaster.error('Error : Form Not Valid');
      this.isSubmitted = false;
      return false;
    } else {
      // Fetch All Form Data On Json Type
      const formObject = this.uploadForm.getRawValue();
      // formObject.suggest = this.uploadForm.value.suggest == 1 ? true : false;
      formObject.id = this.episodeID;
      formObject.updatedBy = this.tokenService.userName;
      formObject.categories = this.value;
      if (this.value.length == 0) {
        this.toaster.error('Error : Category Not Selected, Please Select One');
        this.isSubmitted = false;
        return false;
      }
      if (this.imageUrl) {
        formObject.image = this.imageUrl;
      } else {
        formObject.image = this.episodesData.imageURL;
      }
      if (this.mainImageUrl) {
        formObject.posterImage = this.mainImageUrl;
      } else {
        formObject.posterImage = this.episodesData.posterImageURL;
      }
      this.episodeService.updateEpisode(formObject).subscribe(
        (createResponse: any) => console.log(createResponse),
        error => {
          this.isSubmitted = false;
          console.log('Error : ', error);
        },
        () => {
          this.isSubmitted = false;
          this.router.navigate(['../../'], {relativeTo: this.activatedRoute});
        }
      );
    }
  }

}
